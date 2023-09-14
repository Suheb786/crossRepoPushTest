import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:domain/usecase/credit_card_videocall_verification/credit_card_call_status_update_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_video_kyc/credit_card_video_kyc_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class CreditCardVideoKycViewModel extends BasePageViewModel {
  final CreditCardCallStatusUpdateUseCase _callStatusUpdateUseCase;
  final String agoraAppId = "95c7a3ae0ee54a2bb6999d730d281e59";
  String channelId = "";
  String tempToken = "";
  final int uid = 0;
  final String stringUid = "0";
  final CreditCardVideKycCredentials agoraCredentials;

  late RtcEngine engine;
  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];

  RtcEngineEventHandler? eventHandlers;

  /// call status initiate update
  PublishSubject<CreditCardCallStatusUpdateUseCaseParams> _callStatusUpdateRequest = PublishSubject();

  PublishSubject<Resource<bool>> _callStatusUpdateResponse = PublishSubject();

  Stream<Resource<bool>> get callStatusUpdateStream => _callStatusUpdateResponse.stream;

  /// call status end update
  PublishSubject<CreditCardCallStatusUpdateUseCaseParams> _callEndStatusUpdateRequest = PublishSubject();

  PublishSubject<Resource<bool>> _callEndStatusUpdateResponse = PublishSubject();

  Stream<Resource<bool>> get callEndStatusUpdateStream => _callEndStatusUpdateResponse.stream;

  CreditCardVideoKycViewModel(this.agoraCredentials, this._callStatusUpdateUseCase) {
    channelId = agoraCredentials.channelName;
    tempToken = agoraCredentials.token;
    _initEngine();

    _callStatusUpdateRequest.listen((value) {
      RequestManager(value, createCall: () => _callStatusUpdateUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        //updateLoader();
        _callStatusUpdateResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _callEndStatusUpdateRequest.listen((value) {
      RequestManager(value, createCall: () => _callStatusUpdateUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        //updateLoader();
        _callEndStatusUpdateResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
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
      await engine.adjustRecordingSignalVolume(400);
      debugPrint('----------Enable local audio-----------');
    } catch (e) {
      debugPrint("goinginto catch ------------");
    } finally {
      joinAgoraChannel();
    }
  }

  _addAgoraEventHandlers() async {
    eventHandlers = RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) async {
        print("local user ${connection.localUid} joined");
        isJoined = true;
        await engine.enableLocalVideo(true);
      },
      onUserJoined: (RtcConnection connection, int remoteid, int elapsed) {
        print("remote user $remoteid joined");
        remoteUid.add(remoteid);
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
        print("remote user $remoteId left channel");

        remoteUid.removeWhere((element) => element == remoteId);
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
        debugPrint('Local Audio states --- >   ${stats.toJson()}');
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

    engine.registerEventHandler(eventHandlers!);

    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.enableVideo();
    await engine.startPreview();
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

    callStatusUpdate("S");
    //notifyListeners();
  }

  leaveAgoraChannel() async {
    try {
      await engine.stopPreview();
      await engine.leaveChannel();
    } catch (e) {
      print("error leaving channel");
    } finally {
      await engine.release();
      callEndStatusUpdate("E");
    }

    //notifyListeners();
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

  void callStatusUpdate(String? status) {
    _callStatusUpdateRequest
        .safeAdd(CreditCardCallStatusUpdateUseCaseParams(cardId: agoraCredentials.cardId, status: status));
  }

  void callEndStatusUpdate(String? status) {
    _callEndStatusUpdateRequest
        .safeAdd(CreditCardCallStatusUpdateUseCaseParams(cardId: agoraCredentials.cardId, status: status));
  }

  void leaveChannelWhenAppInBackground() {
    engine.leaveChannel();
  }

  @override
  void dispose() {
    _callStatusUpdateResponse.close();
    _callStatusUpdateRequest.close();
    _callEndStatusUpdateRequest.close();
    _callEndStatusUpdateResponse.close();
    leaveAgoraChannel();
    WakelockPlus.disable();
    super.dispose();
  }
}
