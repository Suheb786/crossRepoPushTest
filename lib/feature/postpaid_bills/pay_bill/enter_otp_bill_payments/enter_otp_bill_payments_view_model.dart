import 'package:domain/model/bill_payments/get_postpaid_biller_list/post_paid_bill_enquiry_request.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:domain/model/bill_payments/validate_biller_otp/validate_biller_otp.dart';
import 'package:domain/usecase/bill_payment/enter_otp_bill_paymnets_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_post_paid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_prepaid_bill_usecase.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterOtpBillPaymentsViewModel extends BasePageViewModel {
  TextEditingController otpController = TextEditingController();
  final EnterOtpBillPaymentsUseCase _enterOtpBillPaymentsUseCase;
  final PayPrePaidUseCase payPrePaidUseCase;
  final PayPostPaidBillUseCase payPostPaidBillUseCase;

  PublishSubject<EnterOtpBillPaymentsUseCaseParams> _enterOtpBillPaymentsRequest = PublishSubject();

  PublishSubject<Resource<ValidateBillerOtp>> _enterOtpBillPaymentsResponse = PublishSubject();

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<Resource<ValidateBillerOtp>> get enterOtpBillPaymentsResponseStream =>
      _enterOtpBillPaymentsResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(true);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  ///resend otp
  PublishSubject<GetTokenUseCaseParams> _getTokenRequest = PublishSubject();

  PublishSubject<Resource<bool>> _transferVerifyResponse = PublishSubject();

  ///transfer verify response stream
  Stream<Resource<bool>> get transferVerifyStream => _transferVerifyResponse.stream;

  void updateTime(BuildContext context) {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    enterOtpBillPayments(context);
    // if (otpController.text.length < 6) {
    //   AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_OTP, cause: Exception());
    //   return;
    // }
    listenForSmsCode();
  }

  EnterOtpBillPaymentsViewModel(this._enterOtpBillPaymentsUseCase,
      this.payPrePaidUseCase,
      this.payPostPaidBillUseCase,) {
    _enterOtpBillPaymentsRequest.listen((value) {
      RequestManager(value, createCall: () => _enterOtpBillPaymentsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _enterOtpBillPaymentsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    payPostPaidBillListener();
    payPrePaidBillListener();
  }

  void enterOtpBillPayments(BuildContext context) {
    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("validate_otp", {"validate_otp_clicked": true});
    var billerType = AppConstantsUtils.BILLER_TYPE;
    var amount = "0.000";
    var currencyCode = "JOD";
    var accountNo = AppConstantsUtils.ACCOUNT_NUMBER;
    var isNewBiller = true;
    if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.PREPAID_KEY) {
      final confirmBillModel =
      ProviderScope.containerOf(context).read(confirmBillPaymentAmountPageViewModelProvider);
      amount = confirmBillModel.amtController.text;
    } else if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.POSTPAID_KEY) {
      final confirmBillModel =
          ProviderScope.containerOf(context).read(confirmBillPaymentAmountPageViewModelProvider);
      amount = confirmBillModel.totalAmountToPay();
    }
    _enterOtpBillPaymentsRequest.safeAdd(EnterOtpBillPaymentsUseCaseParams(
        billerType: billerType,
        amount: amount,
        currencyCode: currencyCode,
        accountNo: accountNo,
        isNewBiller: isNewBiller));
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  /// ---------------- pay prepaid bill -------------------------------- ///
  PublishSubject<PayPrePaidUseCaseParams> _payPrePaidRequest = PublishSubject();

  BehaviorSubject<Resource<PayPrePaid>> _payPrePaidResponse = BehaviorSubject();

  Stream<Resource<PayPrePaid>> get payPrePaidStream => _payPrePaidResponse.stream;

  ///already saved flow.
  void payPrePaidBill(BuildContext context) {
    final confirmBillModel =
    ProviderScope.containerOf(context).read(confirmBillPaymentAmountPageViewModelProvider);

    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("pay_pre_paid", {"pay_pre_paid_clicked": true});
    _payPrePaidRequest.safeAdd(PayPrePaidUseCaseParams(
        billerName: AppConstantsUtils.BILLER_NAME,
        billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
        billingNumber: AppConstantsUtils.SELECTED_BILLING_NUMBER,
        serviceType: AppConstantsUtils.SELECTED_SERVICE_TYPE,
        amount: confirmBillModel.addNewBillDetailsData.isPrepaidCategoryListEmpty == true
            ? confirmBillModel.userEnteredPrePaidAmount
            : "",
        currencyCode: "JOD",
        accountNo: confirmBillModel.addNewBillDetailsData.accountNumber,
        otpCode: otpController.text,
        isNewBiller: confirmBillModel.isNewBiller,
        nickName: AppConstantsUtils.NICK_NAME,
        prepaidCategoryCode: confirmBillModel.addNewBillDetailsData.isPrepaidCategoryListEmpty == false
            ? AppConstantsUtils.PREPAID_CATEGORY_CODE
            : "",
        prepaidCategoryType: confirmBillModel.addNewBillDetailsData.isPrepaidCategoryListEmpty == false
            ? AppConstantsUtils.PREPAID_CATEGORY_TYPE
            : "",
        billingNumberRequired: AppConstantsUtils.SELECTED_BILLING_NUMBER != null &&
                AppConstantsUtils.SELECTED_BILLING_NUMBER != ""
            ? true
            : false,
        CardId: "",
        isCreditCardPayment: false));
  }

  void payPrePaidBillListener() {
    _payPrePaidRequest.listen(
          (params) {
        RequestManager(params, createCall: () => payPrePaidUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
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

  /// ---------------- pay postpaid bill -------------------------------- ///
  PublishSubject<PayPostPaidBillUseCaseParams> _payPostPaidRequest = PublishSubject();

  BehaviorSubject<Resource<PayPostPaidBill>> _payPostPaidResponse = BehaviorSubject();

  Stream<Resource<PayPostPaidBill>> get payPostPaidStream => _payPostPaidResponse.stream;

  void payPostPaidBill(BuildContext context) {
    final confirmBillModel =
    ProviderScope.containerOf(context).read(confirmBillPaymentAmountPageViewModelProvider);

    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("pay_post_paid", {"pay_post_paid_clicked": true});

    List<PostpaidBillInquiry>? tempPostpaidBillInquiryRequestList = [];
    for (int i = 0; i < confirmBillModel.postPaidBillInquiryData!.length; i++) {
      PostPaidBillInquiryData item = confirmBillModel.postPaidBillInquiryData![i];
      if (double.parse(item.dueAmount ?? "0.0") > 0.0) {
        tempPostpaidBillInquiryRequestList.add(PostpaidBillInquiry(
            billerCode: item.billerCode,
            billingNumber: item.billingNo,
            billerName: AppConstantsUtils.BILLER_NAME,
            serviceType: item.serviceType,
            amount: confirmBillModel.totalAmountToPay(),
            fees: item.feesAmt ?? "0.0"));
      }
    }
    tempPostpaidBillInquiryRequestList = tempPostpaidBillInquiryRequestList.toSet().toList();
    _payPostPaidRequest.safeAdd(PayPostPaidBillUseCaseParams(
        billerList: tempPostpaidBillInquiryRequestList,
        accountNo: confirmBillModel.addNewBillDetailsData.accountNumber,
        totalAmount: confirmBillModel.totalAmountToPay(),
        currencyCode: "JOD",
        isNewBiller: true,
        isCreditCardPayment: false,
        CardId: "",
        nickName: AppConstantsUtils.NICK_NAME,
        otpCode: otpController.text));
  }

  void payPostPaidBillListener() {
    _payPostPaidRequest.listen(
          (params) {
        RequestManager(params, createCall: () => payPostPaidBillUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _payPostPaidResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _otpSubject.close();
    _enterOtpBillPaymentsRequest.close();
    _showButtonSubject.close();
    _enterOtpBillPaymentsResponse.close();
    countDownController.disposeTimer();
    _payPrePaidRequest.close();
    _payPrePaidResponse.close();
    _payPostPaidRequest.close();
    _payPostPaidResponse.close();
    super.dispose();
  }
}
