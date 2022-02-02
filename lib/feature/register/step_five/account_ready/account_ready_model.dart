import 'package:domain/model/bank_smart/get_account_details_response.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/usecase/bank_smart/get_account_details_usecase.dart';
import 'package:domain/usecase/user/logout_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AccountReadyViewModel extends BasePageViewModel {
  final AccountReadyArguments arguments;
  final GetAccountDetailsUseCase _getAccountDetailsUseCase;
  final LogoutUseCase _logoutUseCase;

  PublishSubject<LogoutUseCaseParams> _logoutRequest = PublishSubject();
  PublishSubject<Resource<LogoutResponse>> _logoutResponse = PublishSubject();

  Stream<Resource<LogoutResponse>> get logoutStream => _logoutResponse.stream;

  ///get account details request subject
  PublishSubject<GetAccountDetailsUseCaseParams> _getAccountDetailsRequest =
      PublishSubject();

  ///get account details response subject
  PublishSubject<Resource<GetAccountDetailsResponse>>
      _getAccountDetailsResponse = PublishSubject();

  ///get account details response stream
  Stream<Resource<GetAccountDetailsResponse>> get getAccountDetailsStream =>
      _getAccountDetailsResponse.stream;

  AccountReadyViewModel(
      this._getAccountDetailsUseCase, this.arguments, this._logoutUseCase) {
    _getAccountDetailsRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _getAccountDetailsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getAccountDetailsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _logoutRequest.listen((value) {
      RequestManager(value,
              createCall: () => _logoutUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _logoutResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    getAccountDetails();
  }

  void getAccountDetails() {
    _getAccountDetailsRequest.safeAdd(GetAccountDetailsUseCaseParams());
  }

  void logOutUser() {
    _logoutRequest.safeAdd(LogoutUseCaseParams());
  }

  @override
  void dispose() {
    _getAccountDetailsRequest.close();
    _getAccountDetailsResponse.close();
    super.dispose();
  }
}
