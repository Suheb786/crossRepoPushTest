import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:domain/usecase/bill_payment/pay_prepaid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/validate_prepaid_bill_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_details_bill_paymemts_model.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ConfirmBillPaymentAmountPageViewModel extends BasePageViewModel {
  final ValidatePrePaidUseCase validatePrePaidUseCase;
  final PayPrePaidUseCase payPrePaidUseCase;
  String? otpCode = "";
  bool? isNewBiller = false;

  ConfirmBillPaymentAmountPageViewModel(
      this.validatePrePaidUseCase, this.payPrePaidUseCase) {
    validatePrePaidBillListener();
    payPrePaidBillListener();
  }

  TextEditingController amtController = TextEditingController();

  ///get new details bill payments model
  PublishSubject<AddNewDetailsBillPaymentsModel>
      _addNewDetailsBillPaymentsModelResponse = PublishSubject();

  Stream<AddNewDetailsBillPaymentsModel> get getPurposeResponseStream =>
      _addNewDetailsBillPaymentsModelResponse.stream;

  AddNewDetailsBillPaymentsModel data = AddNewDetailsBillPaymentsModel();

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  setData(AddNewDetailsBillPaymentsModel addNewDetailsBillPaymentsModel) {
    _addNewDetailsBillPaymentsModelResponse
        .safeAdd(addNewDetailsBillPaymentsModel);
  }

  /// ---------------- validate prepaid bill -------------------------------- ///
  PublishSubject<ValidatePrePaidUseCaseParams> _validatePrePaidRequest =
      PublishSubject();

  BehaviorSubject<Resource<ValidatePrePaidBill>> _validatePrePaidResponse =
      BehaviorSubject();

  Stream<Resource<ValidatePrePaidBill>> get validatePrePaidStream =>
      _validatePrePaidResponse.stream;

  void validatePrePaidBill() {
    _validatePrePaidRequest.safeAdd(ValidatePrePaidUseCaseParams(
        billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
        amount:
            data.isPrepaidCategoryListEmpty == true ? amtController.text : "",
        serviceType: AppConstantsUtils.SELECTED_SERVICE_TYPE,
        billingNumber: AppConstantsUtils.SELECTED_BILLING_NUMBER,
        prepaidCategoryCode: data.isPrepaidCategoryListEmpty == false
            ? AppConstantsUtils.PREPAID_CATEGORY_CODE
            : "",
        prepaidCategoryType: data.isPrepaidCategoryListEmpty == false
            ? AppConstantsUtils.PREPAID_CATEGORY_TYPE
            : "",
        billingNumberRequired:
            AppConstantsUtils.SELECTED_BILLING_NUMBER != null &&
                    AppConstantsUtils.SELECTED_BILLING_NUMBER != ""
                ? true
                : false));
  }

  void validatePrePaidBillListener() {
    _validatePrePaidRequest.listen(
      (params) {
        RequestManager(params,
                createCall: () =>
                    validatePrePaidUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _validatePrePaidResponse.safeAdd(event);

          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  /// ---------------- pay prepaid bill -------------------------------- ///
  PublishSubject<PayPrePaidUseCaseParams> _payPrePaidRequest = PublishSubject();

  BehaviorSubject<Resource<PayPrePaid>> _payPrePaidResponse = BehaviorSubject();

  Stream<Resource<PayPrePaid>> get payPrePaidStream =>
      _payPrePaidResponse.stream;

  ///already saved flow.
  void payPrePaidBill() {
    _payPrePaidRequest.safeAdd(PayPrePaidUseCaseParams(
        billerName: AppConstantsUtils.BILLER_NAME,
        billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
        billingNumber: AppConstantsUtils.SELECTED_BILLING_NUMBER,
        serviceType: AppConstantsUtils.SELECTED_SERVICE_TYPE,
        amount:
            data.isPrepaidCategoryListEmpty == true ? amtController.text : "",
        currencyCode: "JOD",
        accountNo: data.accountNumber,
        otpCode: otpCode,
        isNewBiller: isNewBiller,
        prepaidCategoryCode: data.isPrepaidCategoryListEmpty == false
            ? AppConstantsUtils.PREPAID_CATEGORY_CODE
            : "",
        prepaidCategoryType: data.isPrepaidCategoryListEmpty == false
            ? AppConstantsUtils.PREPAID_CATEGORY_TYPE
            : "",
        billingNumberRequired:
            AppConstantsUtils.SELECTED_BILLING_NUMBER != null &&
                    AppConstantsUtils.SELECTED_BILLING_NUMBER != ""
                ? true
                : false,
        CardId: "",
        isCreditCardPayment: false));
  }

  void payPrePaidBillListener() {
    _payPrePaidRequest.listen(
      (params) {
        RequestManager(params,
                createCall: () => payPrePaidUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          //to do
          updateLoader();
          _payPrePaidResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {
            _payPrePaidResponse.safeAdd(event);
          }
        });
      },
    );
  }

  validate(String value) {
    if (double.parse(value) > 0.0) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }
}
