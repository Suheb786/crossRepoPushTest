import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:domain/model/account/video_kyc_status.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/usecase/account/get_call_status_usecase.dart';
import 'package:domain/usecase/user/logout_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wakelock/wakelock.dart';

class VideoKycViewModel extends BasePageViewModel {
  final GetCallStatusUseCase _getCallStatusUseCase;
  final LogoutUseCase _logoutUseCase;
  final String agoraAppId = "95c7a3ae0ee54a2bb6999d730d281e59";
  String channelId = "";
  String tempToken = "";
  final int uid = 0;
  final String stringUid = "0";
  final VideKycCredentials agoraCredentials;

  late RtcEngine engine;
  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];

  RtcEngineEventHandler? eventHandlers;

  PublishSubject<GetCallStatusUseCaseParams> _getCallStatusRequest = PublishSubject();
  PublishSubject<Resource<VideoKycStatus>> _getCallStatusResponse = PublishSubject();

  Stream<Resource<VideoKycStatus>> get callStatusStream => _getCallStatusResponse.stream;

  ///logout
  PublishSubject<LogoutUseCaseParams> _logoutRequest = PublishSubject();
  PublishSubject<Resource<LogoutResponse>> _logoutResponse = PublishSubject();

  Stream<Resource<LogoutResponse>> get logoutStream => _logoutResponse.stream;

  VideoKycViewModel(this._getCallStatusUseCase, this.agoraCredentials, this._logoutUseCase) {
    _getCallStatusRequest.listen((value) {
      RequestManager(value, createCall: () => _getCallStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        //updateLoader();
        _getCallStatusResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _logoutRequest.listen((value) {
      RequestManager(value, createCall: () => _logoutUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _logoutResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    channelId = agoraCredentials.channelName;
    tempToken = agoraCredentials.token;
    _initEngine();
  }

  _initEngine() async {
    try {
      engine = createAgoraRtcEngine();
      await engine.initialize(RtcEngineContext(
        appId: agoraAppId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        audioScenario: AudioScenarioType.audioScenarioMeeting,
        logConfig: LogConfig(
          level: LogLevel.logLevelError,
        ),
      ));
      _addAgoraEventHandlers();

      debugPrint(' channelId --  $channelId  token -- $tempToken uid --- $uid');
      debugPrint('---------------------');
      await engine.enableVideo();
      debugPrint('----------Enable Video-----------');
      await engine.enableAudio();
      debugPrint('----------Enable Audio-----------');
      //await _engine.setAudioProfile(AudioProfile.Default, AudioScenario.GameStreaming);
      debugPrint('---------- Audio Profile-----------');
      await engine.startPreview();
      debugPrint('----------Preview-----------');
      debugPrint('----------Channel Profile-----------');
      await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      debugPrint('----------Client Role-----------');
      await engine.setEnableSpeakerphone(true);
      debugPrint('----------Set Speaker phone-----------');
      await engine.enableLocalAudio(true);
      debugPrint('----------Enable local audio-----------');
    } catch (e) {
      debugPrint("goinginto catch ------------");
    } finally {
      joinAgoraChannel();
    }
  }

  void logOutUser() {
    _logoutRequest.safeAdd(LogoutUseCaseParams());
  }

  _addAgoraEventHandlers() {
    eventHandlers = RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) async {
        print("local user ${connection.localUid} joined");
        isJoined = true;
        await engine.enableLocalVideo(true);
      },
      onUserJoined: (RtcConnection connection, int remoteid, int elapsed) {
        print("remote user $remoteUid joined");
        remoteUid.add(uid);
        notifyListeners();
      },
      onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid, RemoteVideoState state,
          RemoteVideoStateReason reason, int elapsed) {
        print("user video state changed --- ${state.toString()}");
      },
      onUserMuteVideo: (RtcConnection connection, int remoteUid, bool muted) {
        print("user video state changed --- ${muted}");
      },
      onUserMuteAudio: (RtcConnection connection, int remoteUid, bool muted) {
        print("user audio state changed --- ${muted}");
      },
      onRemoteAudioStateChanged: (RtcConnection connection, int remoteUid, RemoteAudioState state,
          RemoteAudioStateReason reason, int elapsed) {
        print("user audio state changed --- ${state.toString()}");
        if (state == RemoteAudioState.remoteAudioStateStopped) {
          print("remote user audio paused");
        } else if (state == RemoteVideoState.remoteVideoStateDecoding) {
          print("remote user video start"); // st
        }
      },
      onUserOffline: (RtcConnection connection, int remoteId, UserOfflineReasonType reason) {
        print("remote user $remoteUid left channel");

        remoteUid.removeWhere((element) => element == uid);
        leaveAgoraChannel();
      },
      onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
        print('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
      },
      onFirstRemoteVideoFrame: (RtcConnection connection, int remoteUid, int width, int height, int elapsed) {
        final info = 'firstRemoteVideoFrame: $remoteUid';
        debugPrint('onFirstRemoteVideoFramee --- >   $info ');
      },
      onLeaveChannel: (connection, stats) async {
        isJoined = false;
        remoteUid.clear();
        await engine.stopPreview();
        await engine.leaveChannel();
        await engine.release();
      },
      onFirstLocalAudioFramePublished: (connection, elapsed) {
        debugPrint('First local audio frame published --- >   ${elapsed}');
      },
      onLocalAudioStateChanged: (connection, state, error) {
        debugPrint('Local Audio State Change --- >   ${state.toString()}  ${error.toString()}');
      },
      onLocalAudioStats: (connection, stats) {
        debugPrint('First local audio frame published --- >   ${stats.toString()}');
      },
    );
    /*_engine.setEventHandler(RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) async {
      debugPrint("joinChannelSuccess $uid");
      isJoined = true;
      await _engine.enableLocalVideo(true);
      // notifyListeners();
    }, userJoined: (uid, elapsed) {
      debugPrint("userJoined $uid");
      remoteUid.add(uid);
      notifyListeners();
    }, userOffline: (uid, reason) {
      debugPrint("userOffline $uid");
      remoteUid.removeWhere((element) => element == uid);
      leaveAgoraChannel();
      //notifyListeners();
    }, leaveChannel: (stats) async {
      debugPrint('leave channel');
      isJoined = false;
      remoteUid.clear();
      await _engine.leaveChannel().then((value) async => await _engine.destroy());
      // notifyListeners();
      //leaveAgoraChannel();
      //getCallStatus();
    }, connectionStateChanged: (type, reason) {
      debugPrint('type----->${type}');
    }));*/
  }

  joinAgoraChannel() async {
    if (Platform.isAndroid) {
      await [
        Permission.microphone,
        Permission.camera,
      ].request();
    }

    await engine.joinChannel(
      token: tempToken,
      channelId: channelId,
      uid: uid,
      options: const ChannelMediaOptions(),
    );

    notifyListeners();
  }

  leaveAgoraChannel() async {
    try {
      await engine.stopPreview();
      await engine.leaveChannel();
    } catch (e) {
      print("error leaving channel");
    } finally {
      await engine.release();
      getCallStatus();
    }
  }

  switchAgoraCamera() {
    engine.switchCamera().then((value) {
      switchCamera = !switchCamera;
      notifyListeners();
    }).catchError((err) {});
  }

  switchAgoraRender() {
    switchRender = !switchRender;
    remoteUid = List.of(remoteUid.reversed);
    notifyListeners();
  }

  void getCallStatus() {
    _getCallStatusRequest.safeAdd(GetCallStatusUseCaseParams(session: tempToken));
  }

  void leaveChannelWhenAppInBackground() {
    engine.leaveChannel();
  }

  @override
  void dispose() {
    _getCallStatusRequest.close();
    _getCallStatusResponse.close();
    _logoutRequest.close();
    _logoutResponse.close();
    Wakelock.disable();
    super.dispose();
  }
}
