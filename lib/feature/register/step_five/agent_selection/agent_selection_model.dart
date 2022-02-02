import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/model/account/request_call_status.dart';
import 'package:domain/usecase/account/check_gender_status_usecase.dart';
import 'package:domain/usecase/account/request_call_usecase.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class AgentSelectionViewModel extends BasePageViewModel {
  final CheckGenderStatusUseCase _checkGenderStatusUseCase;
  final RequestCallUseCase _requestCallUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  PublishSubject<CheckGenderStatusUseCaseParams> _checkGenderStatusRequest =
      PublishSubject();
  PublishSubject<Resource<AgentGenderStatus>> _checkGenderStatusResponse =
      PublishSubject();

  Stream<Resource<AgentGenderStatus>> get getAgentAvailabilityStream =>
      _checkGenderStatusResponse.stream;

  PublishSubject<RequestCallUseCaseParams> _requestCallRequest =
      PublishSubject();
  PublishSubject<Resource<RequestCallStatus>> _requestCallResponse =
      PublishSubject();

  Stream<Resource<RequestCallStatus>> get requestCallStream =>
      _requestCallResponse.stream;

  AgentSelectionViewModel(
      this._checkGenderStatusUseCase, this._requestCallUseCase) {
    _checkGenderStatusRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => _checkGenderStatusUseCase.execute(params: value),
      ).asFlow().listen((event) {
        _checkGenderStatusResponse.safeAdd(event);
      });
    });

    _requestCallRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => _requestCallUseCase.execute(params: value),
      ).asFlow().listen((event) {
        updateLoader();
        _requestCallResponse.safeAdd(event);
      });
    });
  }

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    notifyListeners();
  }

  void checkAvailableAgent() {
    _checkGenderStatusRequest.safeAdd(CheckGenderStatusUseCaseParams());
  }

  void getAgoraCredentials() {
    _requestCallRequest.safeAdd(RequestCallUseCaseParams());
  }

  @override
  void dispose() {
    _requestCallRequest.close();
    _requestCallResponse.close();
    _checkGenderStatusResponse.close();
    _checkGenderStatusRequest.close();
    super.dispose();
  }

  void checkUserStatus() {}
}
