import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/usecase/account/check_gender_status_usecase.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class AgentSelectionViewModel extends BasePageViewModel {
  final CheckGenderStatusUseCase _checkGenderStatusUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  PublishSubject<CheckGenderStatusUseCaseParams> _checkGenderStatusRequest =
      PublishSubject();
  PublishSubject<Resource<AgentGenderStatus>> _checkGenderStatusResponse =
      PublishSubject();

  Stream<Resource<AgentGenderStatus>> get getAgentAvailabilityStream =>
      _checkGenderStatusResponse.stream;

  AgentSelectionViewModel(this._checkGenderStatusUseCase) {
    _checkGenderStatusRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => _checkGenderStatusUseCase.execute(params: value),
      ).asFlow().listen((event) {
        updateLoader();
        _checkGenderStatusResponse.safeAdd(event);
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
}
