import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/model/account/request_call_status.dart';
import 'package:domain/usecase/account/check_gender_status_usecase.dart';
import 'package:domain/usecase/account/request_call_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_initiate/credit_card_videocall_initiate_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardVideoCallInitiatePageViewModel extends BasePageViewModel {
  final CreditCardVideoCallInitiateArgs creditCardVideoCallInitiateArgs;
  final RequestCallUseCase _requestCallUseCase;
  final CheckGenderStatusUseCase _checkAgentAvailabilityStatusUseCase;

  ///request call
  PublishSubject<RequestCallUseCaseParams> _requestCallRequest =
      PublishSubject();

  PublishSubject<Resource<RequestCallStatus>> _requestCallResponse =
      PublishSubject();

  Stream<Resource<RequestCallStatus>> get requestCallStream =>
      _requestCallResponse.stream;

  ///check agent availability
  PublishSubject<CheckGenderStatusUseCaseParams>
      _checkAgentAvailabilityStatusRequest = PublishSubject();
  PublishSubject<Resource<AgentGenderStatus>>
      _checkAgentAvailabilityStatusResponse = PublishSubject();

  Stream<Resource<AgentGenderStatus>> get getAgentAvailabilityStream =>
      _checkAgentAvailabilityStatusResponse.stream;

  CreditCardVideoCallInitiatePageViewModel(
      this._requestCallUseCase,
      this.creditCardVideoCallInitiateArgs,
      this._checkAgentAvailabilityStatusUseCase) {
    _requestCallRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => _requestCallUseCase.execute(params: value),
      ).asFlow().listen((event) {
        updateLoader();
        _requestCallResponse.safeAdd(event);
      });
    });

    _checkAgentAvailabilityStatusRequest.listen((value) {
      RequestManager(
        value,
        createCall: () =>
            _checkAgentAvailabilityStatusUseCase.execute(params: value),
      ).asFlow().listen((event) {
        //updateLoader();
        _checkAgentAvailabilityStatusResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void getAgoraCredentials() {
    _requestCallRequest
        .safeAdd(RequestCallUseCaseParams(type: "CREDITCARDREQ"));
  }

  void checkAvailableAgent() {
    _checkAgentAvailabilityStatusRequest
        .safeAdd(CheckGenderStatusUseCaseParams());
  }

  @override
  void dispose() {
    _requestCallRequest.close();
    _requestCallResponse.close();
    _checkAgentAvailabilityStatusResponse.close();
    _checkAgentAvailabilityStatusRequest.close();
    super.dispose();
  }
}
