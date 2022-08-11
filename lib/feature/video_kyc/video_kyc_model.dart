import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
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

  late final RtcEngine _engine;
  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];

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
      _engine = await RtcEngine.createWithContext(RtcEngineContext(agoraAppId));
      _addAgoraEventHandlers();

      await _engine.enableVideo();
      await _engine.startPreview();
      await _engine.setChannelProfile(ChannelProfile.Communication);
      await _engine.setClientRole(ClientRole.Broadcaster);
    } catch (e) {
      joinAgoraChannel();
    }
  }

  void logOutUser() {
    _logoutRequest.safeAdd(LogoutUseCaseParams());
  }

  _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
      debugPrint("joinChannelSuccess $uid");
      isJoined = true;
      notifyListeners();
    }, userJoined: (uid, elapsed) {
      debugPrint("userJoined $uid");
      remoteUid.add(uid);
      notifyListeners();
    }, userOffline: (uid, reason) {
      debugPrint("userOffline $uid");
      remoteUid.removeWhere((element) => element == uid);
      leaveAgoraChannel();
      //notifyListeners();
    }, leaveChannel: (stats) {
      debugPrint('leave channel');
      isJoined = false;
      remoteUid.clear();
      // notifyListeners();
      //leaveAgoraChannel();
      //getCallStatus();
    }, connectionStateChanged: (type, reason) {
      debugPrint('type----->${type}');
    }));
  }

  joinAgoraChannel() async {
    if (Platform.isAndroid) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(tempToken, channelId, null, uid);
    notifyListeners();
  }

  leaveAgoraChannel() async {
    await _engine.leaveChannel();
    //notifyListeners();
    getCallStatus();
  }

  switchAgoraCamera() {
    _engine.switchCamera().then((value) {
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
    _engine.leaveChannel();
  }

  @override
  void dispose() {
    _engine.destroy();
    _getCallStatusRequest.close();
    _getCallStatusResponse.close();
    Wakelock.disable();
    super.dispose();
  }
}
