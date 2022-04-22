import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
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

class CreditCardVideoKycViewModel extends BasePageViewModel {
  final CreditCardCallStatusUpdateUseCase _callStatusUpdateUseCase;
  final String agoraAppId = "95c7a3ae0ee54a2bb6999d730d281e59";
  String channelId = "";
  String tempToken = "";
  final int uid = 0;
  final String stringUid = "0";
  final CreditCardVideKycCredentials agoraCredentials;

  late final RtcEngine _engine;
  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];

  /// call status initiate update
  PublishSubject<CreditCardCallStatusUpdateUseCaseParams>
      _callStatusUpdateRequest = PublishSubject();

  PublishSubject<Resource<bool>> _callStatusUpdateResponse = PublishSubject();

  Stream<Resource<bool>> get callStatusUpdateStream =>
      _callStatusUpdateResponse.stream;

  /// call status end update
  PublishSubject<CreditCardCallStatusUpdateUseCaseParams>
      _callEndStatusUpdateRequest = PublishSubject();

  PublishSubject<Resource<bool>> _callEndStatusUpdateResponse =
      PublishSubject();

  Stream<Resource<bool>> get callEndStatusUpdateStream =>
      _callEndStatusUpdateResponse.stream;

  CreditCardVideoKycViewModel(
      this.agoraCredentials, this._callStatusUpdateUseCase) {
    channelId = agoraCredentials.channelName;
    tempToken = agoraCredentials.token;
    _initEngine();

    _callStatusUpdateRequest.listen((value) {
      RequestManager(value,
              createCall: () => _callStatusUpdateUseCase.execute(params: value))
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
      RequestManager(value,
              createCall: () => _callStatusUpdateUseCase.execute(params: value))
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

  _addAgoraEventHandlers() {
    _engine.setEventHandler(
        RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
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
    callStatusUpdate("S");
    //notifyListeners();
  }

  leaveAgoraChannel() async {
    await _engine.leaveChannel();
    callEndStatusUpdate("E");
    //notifyListeners();
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

  void callStatusUpdate(String? status) {
    _callStatusUpdateRequest.safeAdd(CreditCardCallStatusUpdateUseCaseParams(
        cardId: agoraCredentials.cardId, status: status));
  }

  void callEndStatusUpdate(String? status) {
    _callEndStatusUpdateRequest.safeAdd(CreditCardCallStatusUpdateUseCaseParams(
        cardId: agoraCredentials.cardId, status: status));
  }

  @override
  void dispose() {
    _engine.destroy();
    super.dispose();
  }
}
