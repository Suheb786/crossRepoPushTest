import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/model/account/request_call_status.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:domain/usecase/account/check_gender_status_usecase.dart';
import 'package:domain/usecase/account/request_call_usecase.dart';
import 'package:domain/usecase/bank_smart/create_account_usecase.dart';
import 'package:domain/usecase/bank_smart/get_account_usecase.dart';
import 'package:domain/usecase/user/check_customer_status_usecase.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AgentSelectionViewModel extends BasePageViewModel {
  final CheckGenderStatusUseCase _checkGenderStatusUseCase;
  final CheckCustomerStatusUseCase _checkCustomerStatusUseCase;
  final GetAccountUseCase _getAccountUseCase;
  final CreateAccountUseCase _createAccountUseCase;
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

  ///User Status subject holder
  PublishSubject<CheckCustomerStatusUseCaseParams> _checkCustomerStatusRequest =
      PublishSubject();

  ///User Status response holder
  PublishSubject<Resource<CustomerStatus>> _checkCustomerStatusResponse =
      PublishSubject();

  ///User Status stream
  Stream<Resource<CustomerStatus>> get customerStatusStream =>
      _checkCustomerStatusResponse.stream;

  ///get Account subject holder
  PublishSubject<GetAccountUseCaseParams> _getAccountRequest = PublishSubject();

  ///get Account response holder
  PublishSubject<Resource<GetAccountResponse>> _getAccountResponse =
      PublishSubject();

  ///get Account stream
  Stream<Resource<GetAccountResponse>> get getAccountStream =>
      _getAccountResponse.stream;

  ///create Account subject holder
  PublishSubject<CreateAccountUseCaseParams> _createAccountRequest =
      PublishSubject();

  ///create Account response holder
  PublishSubject<Resource<CreateAccountResponse>> _createAccountResponse =
      PublishSubject();

  ///create Account stream
  Stream<Resource<CreateAccountResponse>> get createAccountStream =>
      _createAccountResponse.stream;

  AgentSelectionViewModel(
      this._checkGenderStatusUseCase,
      this._requestCallUseCase,
      this._checkCustomerStatusUseCase,
      this._getAccountUseCase,
      this._createAccountUseCase) {
    _checkGenderStatusRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => _checkGenderStatusUseCase.execute(params: value),
      ).asFlow().listen((event) {
        _checkGenderStatusResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
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

    _checkCustomerStatusRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _checkCustomerStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkCustomerStatusResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _getAccountRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAccountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _createAccountRequest.listen((value) {
      RequestManager(value,
              createCall: () => _createAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _createAccountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
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

  void checkUserStatus() {
    _checkCustomerStatusRequest.safeAdd(CheckCustomerStatusUseCaseParams());
  }

  void getAccount() {
    _getAccountRequest.safeAdd(GetAccountUseCaseParams());
  }

  void createAccount(CustomerAccountDetails customerAccountDetails,
      CustomerInformation customerInformation) {
    _createAccountRequest.safeAdd(CreateAccountUseCaseParams(
        accountDetails: customerAccountDetails,
        customerInformation: customerInformation));
  }

  @override
  void dispose() {
    _requestCallRequest.close();
    _requestCallResponse.close();
    _checkGenderStatusResponse.close();
    _checkGenderStatusRequest.close();
    // _checkCustomerStatusRequest.close();
    // _checkCustomerStatusResponse.close();
    _getAccountRequest.close();
    _getAccountResponse.close();
    _createAccountRequest.close();
    _createAccountResponse.close();
    super.dispose();
  }
}
