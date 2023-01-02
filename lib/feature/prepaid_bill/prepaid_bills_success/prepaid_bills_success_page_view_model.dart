import 'package:domain/model/bill_payments/pay_prepaid_bill/paid_bill.dart';
import 'package:domain/usecase/bill_payment/add_new_prepaid_biller_usecase.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/prepaid_bill/prepaid_bills_success/prepaid_bills_success_page.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';

class PrePaidBillsSuccessPageViewModel extends BasePageViewModel {
  final PrePaidBillsSuccessPageArguments arguments;
  AddNewPrepaidBillerUseCase addNewPrepaidBillerUseCase;

  PrePaidBillsSuccessPageViewModel(this.arguments, this.addNewPrepaidBillerUseCase) {
    if (AppConstantsUtils.IS_NEW_PAYMENT == true && AppConstantsUtils.NICK_NAME.toString().isNotEmpty) {
      if (AppConstantsUtils.IS_NEW_BILL_ADD_API_CALL == true) {
        AppConstantsUtils.IS_NEW_BILL_ADD_API_CALL = false;
        Future.delayed(Duration(milliseconds: 10)).then((value) => addNewPrepaidBiller());
      }
    }

    _addNewPrepaidBillerListener();
  }

  /// ---------------- Call Api AddNewPrepaidBiller -------------------- ///

  PublishSubject<Resource<bool>> _addNewPrepaidBillerResponce = PublishSubject();

  Stream<Resource<bool>> get addNewPrepaidBillerStream => _addNewPrepaidBillerResponce.stream;

  PublishSubject<AddNewPrepaidBillerUseCaseParams> _addNewPrepaidBillerRequest = PublishSubject();

  void addNewPrepaidBiller() {
    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("add_new_pre_paid_biller", {"add_new_pre_paid_biller_call": true});
    _addNewPrepaidBillerRequest.safeAdd(
      AddNewPrepaidBillerUseCaseParams(
          prepaidCategoryType: AppConstantsUtils.PREPAID_CATEGORY_TYPE,
          prepaidCategoryCode: AppConstantsUtils.PREPAID_CATEGORY_CODE,
          serviceType: AppConstantsUtils.SELECTED_SERVICE_TYPE,
          serviceCode: AppConstantsUtils.SELECTED_SERVICE_CODE,
          billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
          billerName: AppConstantsUtils.BILLER_NAME,
          billingNumber: AppConstantsUtils.SELECTED_BILLING_NUMBER,
          nickname: AppConstantsUtils.NICK_NAME,
          amount: AppConstantsUtils.ACCOUNT_NUMBER,
          billingNumberRequired: AppConstantsUtils.SELECTED_BILLING_NUMBER_REQUIRED),
    );
  }

  void _addNewPrepaidBillerListener() {
    _addNewPrepaidBillerRequest.listen(
      (params) {
        RequestManager(params, createCall: () => addNewPrepaidBillerUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _addNewPrepaidBillerResponce.safeAdd(event);
        });
      },
    );
  }

  String getBillerName(BuildContext context, PaidBill paidBill) {
    return StringUtils.isDirectionRTL(context) ? paidBill.billerNameAR ?? "" : paidBill.billName ?? "";
  }
}
