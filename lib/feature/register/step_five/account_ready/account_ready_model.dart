import 'package:domain/model/bank_smart/get_account_details_response.dart';
import 'package:domain/usecase/bank_smart/get_account_details_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AccountReadyViewModel extends BasePageViewModel {
  final GetAccountDetailsUseCase _getAccountDetailsUseCase;

  ///get account details request subject
  PublishSubject<GetAccountDetailsUseCaseParams> _getAccountDetailsRequest =
      PublishSubject();

  ///get account details response subject
  PublishSubject<Resource<GetAccountDetailsResponse>>
      _getAccountDetailsResponse = PublishSubject();

  ///get account details response stream
  Stream<Resource<GetAccountDetailsResponse>> get getAccountDetailsStream =>
      _getAccountDetailsResponse.stream;

  AccountReadyViewModel(this._getAccountDetailsUseCase) {
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

    getAccountDetails();
  }

  void getAccountDetails() {
    _getAccountDetailsRequest.safeAdd(GetAccountDetailsUseCaseParams());
  }

  @override
  void dispose() {
    _getAccountDetailsRequest.close();
    _getAccountDetailsResponse.close();
    super.dispose();
  }
}
