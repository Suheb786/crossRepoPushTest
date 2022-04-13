import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:domain/usecase/credit_card_videocall_verification/credit_card_call_status_update_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_video_kyc/credit_card_video_kyc_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardVideoKycViewModel extends BasePageViewModel {
  CreditCardCallStatusUpdateUseCase _callStatusUpdateUseCase;
  final String agoraAppId = "95c7a3ae0ee54a2bb6999d730d281e59";
  String channelId = "";
  String tempToken = "";
  final int uid = 0;
  final String stringUid = "0";
  final CreditCardVideKycCredentials agoraCredentials;

  late final RtcEngine _engine;
  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];

  /// call status update
  PublishSubject<CreditCardCallStatusUpdateUseCaseParams>
      _callStatusUpdateRequest = PublishSubject();

  PublishSubject<Resource<bool>> _callStatusUpdateResponse = PublishSubject();

  Stream<Resource<bool>> get callStatusUpdateStream =>
      _callStatusUpdateResponse.stream;

  CreditCardVideoKycViewModel(
      this.agoraCredentials, this._callStatusUpdateUseCase) {
    channelId = agoraCredentials.channelName;
    tempToken = agoraCredentials.token;
    _initEngine();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(agoraAppId));
    _addAgoraEventHandlers();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.Communication);
    await _engine.setClientRole(ClientRole.Broadcaster);

    joinAgoraChannel();
  }

  _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        print("joinChannelSuccess $uid");
        isJoined = true;
        notifyListeners();
      },
      userJoined: (uid, elapsed) {
        print("userJoined $uid");
        remoteUid.add(uid);
        notifyListeners();
      },
      userOffline: (uid, reason) {
        print("userOffline $uid");
        remoteUid.removeWhere((element) => element == uid);
        notifyListeners();
      },
      leaveChannel: (stats) {
        isJoined = false;
        remoteUid.clear();
        notifyListeners();
      },
    ));
  }

  joinAgoraChannel() async {
    if (Platform.isAndroid) {
      await [Permission.microphone, Permission.camera].request();
    }
    print("Joininig");
    await _engine.joinChannel(tempToken, channelId, null, uid);
    callStatusUpdate("E");
    notifyListeners();
  }

  leaveAgoraChannel() async {
    await _engine.leaveChannel();
    callStatusUpdate("E");
    //notifyListeners();
  }

  switchAgoraCamera() {
    _engine.switchCamera().then((value) {
      switchCamera = !switchCamera;
      notifyListeners();
    }).catchError((err) {
      print('switchCamera $err');
    });
  }

  switchAgoraRender() {
    switchRender = !switchRender;
    remoteUid = List.of(remoteUid.reversed);
    notifyListeners();
  }

  void callStatusUpdate(String? status) {
    _callStatusUpdateRequest.safeAdd(
        CreditCardCallStatusUpdateUseCaseParams(cardId: "", status: status));
  }

  @override
  void dispose() {
    _engine.destroy();
    super.dispose();
  }
}
