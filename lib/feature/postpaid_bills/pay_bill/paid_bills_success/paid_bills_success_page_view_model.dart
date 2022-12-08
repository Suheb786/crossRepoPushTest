import 'package:domain/usecase/bill_payment/add_new_postpaid_biller_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/paid_bills_success/paid_bills_success_page.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class PaidBillsSuccessPageViewModel extends BasePageViewModel {
  final PaidBillsSuccessPageArguments arguments;
  AddNewPostpaidBillerUseCase addNewPostpaidBillerUseCase;

  PaidBillsSuccessPageViewModel(
      this.arguments, this.addNewPostpaidBillerUseCase) {
    if (AppConstantsUtils.IS_NEW_PAYMENT &&
        AppConstantsUtils.NICK_NAME.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 200))
          .then((value) => addNewPostpaidBiller());
    }
    _addNewPostpaidBillerListener();
  }

  /// ---------------- Call Api AddNewPostpaidBiller -------------------- ///

  PublishSubject<AddNewPostpaidBillerUseCaseParams>
      _addNewPostpaidBillerRequest = PublishSubject();

  PublishSubject<Resource<bool>> _addNewPostpaidBillerResponce =
      PublishSubject();

  Stream<Resource<bool>> get addNewPostpaidStream =>
      _addNewPostpaidBillerResponce.stream;

  void addNewPostpaidBiller() {
    _addNewPostpaidBillerRequest.safeAdd(
      AddNewPostpaidBillerUseCaseParams(
        serviceType: AppConstantsUtils.SELECTED_SERVICE_TYPE,
        billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
        billingNumber: AppConstantsUtils.SELECTED_BILLING_NUMBER,
        nickname: AppConstantsUtils.NICK_NAME,
      ),
    );
  }

  void _addNewPostpaidBillerListener() {
    _addNewPostpaidBillerRequest.listen(
      (params) {
        RequestManager(params,
                createCall: () =>
                    addNewPostpaidBillerUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _addNewPostpaidBillerResponce.safeAdd(event);
        });
      },
    );
  }

  @override
  void dispose() {
    _addNewPostpaidBillerRequest.close();
    _addNewPostpaidBillerResponce.close();
    super.dispose();
  }
}
