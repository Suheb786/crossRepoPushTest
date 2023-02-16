import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_details_bill_paymemts_model.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/post_paid_bill_enquiry_request.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:domain/model/bill_payments/validate_biller_otp/validate_biller_otp.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:domain/usecase/bill_payment/enter_otp_bill_paymnets_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_post_paid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_prepaid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/post_paid_bill_inquiry_usecase.dart';
import 'package:domain/usecase/bill_payment/validate_prepaid_bill_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ConfirmBillPaymentAmountPageViewModel extends BasePageViewModel {
  final ValidatePrePaidUseCase validatePrePaidUseCase;
  final PayPrePaidUseCase payPrePaidUseCase;
  final PostPaidBillInquiryUseCase postPaidBillInquiryUseCase;
  final PayPostPaidBillUseCase payPostPaidBillUseCase;
  final EnterOtpBillPaymentsUseCase _enterOtpBillPaymentsUseCase;

  bool isPartial = false;
  String? minRange = "0";
  String? maxRange = "0";

  String? otpCode = "";
  String? validationCode = "";
  bool? isNewBiller = false;

  bool? isOtpRequired = false;
  bool? isOtpSend = false;
  var isDateOk = true;

  ConfirmBillPaymentAmountPageViewModel(this.validatePrePaidUseCase, this.payPrePaidUseCase,
      this.postPaidBillInquiryUseCase, this.payPostPaidBillUseCase, this._enterOtpBillPaymentsUseCase) {
    validatePrePaidBillListener();
    payPrePaidBillListener();
    postPaidBillInquiryListener();
    payPostPaidBillListener();
    enterOtpBillPaymentsListener();
  }

  TextEditingController amtController = TextEditingController(text: "0.0");
  String? dueAmtController = "0";
  TextEditingController feeAmtController = TextEditingController(text: "0.0");
  String? feeAmtValue = "0";

  ///get new details bill payments model
  PublishSubject<AddNewDetailsBillPaymentsModel> _addNewDetailsBillPaymentsModelResponse = PublishSubject();

  Stream<AddNewDetailsBillPaymentsModel> get getPurposeResponseStream =>
      _addNewDetailsBillPaymentsModelResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  AddNewDetailsBillPaymentsModel addNewBillDetailsData = AddNewDetailsBillPaymentsModel();

  setData(AddNewDetailsBillPaymentsModel addNewDetailsBillPaymentsModel) {
    _addNewDetailsBillPaymentsModelResponse.safeAdd(addNewDetailsBillPaymentsModel);
  }

  /// ---------------- post paid bill enquiry -------------------------------- ///
  List<PostPaidBillInquiryData>? postPaidBillInquiryData = [];

  PublishSubject<PostPaidBillInquiryUseCaseParams> _postPaidBillEnquiryRequest = PublishSubject();

  BehaviorSubject<Resource<PostPaidBillInquiry>> _postPaidBillEnquiryResponse = BehaviorSubject();

  Stream<Resource<PostPaidBillInquiry>> get postPaidBillEnquiryStream => _postPaidBillEnquiryResponse.stream;

  void postPaidBillInquiry() {
    List<PostpaidBillInquiry> postPaidRequestListJson = [];
    postPaidRequestListJson.add(PostpaidBillInquiry(
        billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
        serviceType: AppConstantsUtils.SELECTED_SERVICE_TYPE,
        billingNumber: AppConstantsUtils.SELECTED_BILLING_NUMBER,
        nickName: AppConstantsUtils.NICK_NAME));

    _postPaidBillEnquiryRequest
        .safeAdd(PostPaidBillInquiryUseCaseParams(postpaidBillInquiries: postPaidRequestListJson));
  }

  void postPaidBillInquiryListener() {
    _postPaidBillEnquiryRequest.listen(
      (params) {
        RequestManager(params, createCall: () => postPaidBillInquiryUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _postPaidBillEnquiryResponse.safeAdd(event);
        });
      },
    );
  }

  /// ---------------- pay postpaid bill -------------------------------- ///
  PublishSubject<PayPostPaidBillUseCaseParams> _payPostPaidRequest = PublishSubject();

  BehaviorSubject<Resource<PayPostPaidBill>> _payPostPaidResponse = BehaviorSubject();

  Stream<Resource<PayPostPaidBill>> get payPostPaidStream => _payPostPaidResponse.stream;

  void payPostPaidBill() {
    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("pay_post_paid", {"pay_post_paid_clicked": true});

    List<PostpaidBillInquiry>? tempPostpaidBillInquiryRequestList = [];
    for (int i = 0; i < postPaidBillInquiryData!.length; i++) {
      PostPaidBillInquiryData item = postPaidBillInquiryData![i];
      if (double.parse(item.dueAmount ?? "0.0") > 0.0) {
        tempPostpaidBillInquiryRequestList.add(PostpaidBillInquiry(
          billerCode: item.billerCode,
          billingNumber: item.billingNo,
          billingNo: item.billingNo,
          billerName: AppConstantsUtils.BILLER_NAME,
          serviceType: item.serviceType,
          nickName: AppConstantsUtils.NICK_NAME,
          amount: totalAmountToPay(),
          dueAmount: totalDueBillAmtFromApiPostPaid(),
          fees: item.feesAmt ?? "0.0",
          inqRefNo: item.inqRefNo ?? "",
          isPartialAllowed: item.isPartial ?? false,
        ));
      }
    }
    tempPostpaidBillInquiryRequestList = tempPostpaidBillInquiryRequestList.toSet().toList();
    _payPostPaidRequest.safeAdd(PayPostPaidBillUseCaseParams(
        billerList: tempPostpaidBillInquiryRequestList,
        accountNo: addNewBillDetailsData.accountNumber,
        totalAmount: totalAmountToPay(),
        currencyCode: "JOD",
        isNewBiller: false,
        isCreditCardPayment: false,
        CardId: "NewPostPaid",
        nickName: AppConstantsUtils.NICK_NAME,
        otpCode: ""));
  }

  addAllBillAmt() {
    var totalBillAmt = 0.0;
    postPaidBillInquiryData!.forEach((element) {
      totalBillAmt = double.parse(element.dueAmount ?? "0.0") + totalBillAmt;
    });
    return totalBillAmt.toStringAsFixed(3);
  }

  totalDueBillAmtFromApiPostPaid() {
    var totalBillAmtFromApiPostPaid = 0.0;
    postPaidBillInquiryData!.forEach((element) {
      totalBillAmtFromApiPostPaid =
          double.parse(element.actualDueAmountFromApi ?? "0.0") + totalBillAmtFromApiPostPaid;
    });
    return totalBillAmtFromApiPostPaid.toStringAsFixed(3);
  }

  ///totalAmountToPay
  totalAmountToPay({bool isDisplay: false}) {
    if (isPartial == true) {
      if (double.parse(addAllBillAmt() ?? "0") != double.parse(dueAmtController ?? "0")) {
        if (isDisplay == true) {
          return (double.parse(dueAmtController ?? "0") + double.parse(feeAmtValue ?? "0"))
              .toStringAsFixed(3);
        } else {
          return (double.parse(dueAmtController ?? "0")).toStringAsFixed(3);
        }
      }
      return addAllBillAmt();
    }
    return addAllBillAmt();
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

  /// ---------------- validate prepaid bill -------------------------------- ///
  PublishSubject<ValidatePrePaidUseCaseParams> _validatePrePaidRequest = PublishSubject();

  BehaviorSubject<Resource<ValidatePrePaidBill>> _validatePrePaidResponse = BehaviorSubject();

  Stream<Resource<ValidatePrePaidBill>> get validatePrePaidStream => _validatePrePaidResponse.stream;

  void validatePrePaidBill() {
    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("validate_pre_paid_saved_bill", {"validate_pre_paid_saved_bill_call": true});
    _validatePrePaidRequest.safeAdd(ValidatePrePaidUseCaseParams(
        billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
        amount: AppConstantsUtils.IS_PRE_PAID_CATEGORY_LIST_EMPTY == true ? amtController.text : "",
        serviceType: AppConstantsUtils.SELECTED_SERVICE_TYPE,
        billingNumber: AppConstantsUtils.SELECTED_BILLING_NUMBER,
        prepaidCategoryCode: AppConstantsUtils.IS_PRE_PAID_CATEGORY_LIST_EMPTY == false
            ? AppConstantsUtils.PREPAID_CATEGORY_CODE
            : "",
        prepaidCategoryType: AppConstantsUtils.IS_PRE_PAID_CATEGORY_LIST_EMPTY == false
            ? AppConstantsUtils.PREPAID_CATEGORY_TYPE
            : "",
        billingNumberRequired: AppConstantsUtils.SELECTED_BILLING_NUMBER != null &&
            AppConstantsUtils.SELECTED_BILLING_NUMBER != ""
            ? true
            : false));
  }

  void validatePrePaidBillListener() {
    _validatePrePaidRequest.listen(
          (params) {
        RequestManager(params, createCall: () => validatePrePaidUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _validatePrePaidResponse.safeAdd(event);

          if (event.status == Status.ERROR) {
            ///LOG EVENT TO FIREBASE
            FireBaseLogUtil.fireBaseLog(
                "validate_pre_paid_saved_bill_fail", {"validate_pre_paid_saved_bill_fail_call": true});
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  /// ---------------- pay prepaid bill -------------------------------- ///
  PublishSubject<PayPrePaidUseCaseParams> _payPrePaidRequest = PublishSubject();

  BehaviorSubject<Resource<PayPrePaid>> _payPrePaidResponse = BehaviorSubject();

  Stream<Resource<PayPrePaid>> get payPrePaidStream => _payPrePaidResponse.stream;

  ///already saved flow.
  void payPrePaidBill() {
    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("pay_pre_paid", {"pay_pre_paid_clicked": true});
    _payPrePaidRequest.safeAdd(PayPrePaidUseCaseParams(
        billerName: AppConstantsUtils.BILLER_NAME,
        billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
        billingNumber: AppConstantsUtils.SELECTED_BILLING_NUMBER,
        serviceType: AppConstantsUtils.SELECTED_SERVICE_TYPE,
        amount: double.parse(amtController.text).toStringAsFixed(3),
        fees: double.parse(feeAmtValue ?? "0").toStringAsFixed(3),
        validationCode: validationCode ?? "",
        currencyCode: "JOD",
        accountNo: addNewBillDetailsData.accountNumber,
        otpCode: otpCode,
        isNewBiller: isNewBiller,
        nickName: AppConstantsUtils.NICK_NAME,
        prepaidCategoryCode: addNewBillDetailsData.isPrepaidCategoryListEmpty == false
            ? AppConstantsUtils.PREPAID_CATEGORY_CODE
            : "",
        prepaidCategoryType: addNewBillDetailsData.isPrepaidCategoryListEmpty == false
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

  /// ----------------validate Otp Bill Payments Request-------------------------------- ///

  PublishSubject<EnterOtpBillPaymentsUseCaseParams> _enterOtpBillPaymentsRequest = PublishSubject();

  PublishSubject<Resource<ValidateBillerOtp>> _enterOtpBillPaymentsResponse = PublishSubject();

  Stream<Resource<ValidateBillerOtp>> get enterOtpBillPaymentsResponseStream =>
      _enterOtpBillPaymentsResponse.stream;

  void enterOtpBillPaymentsListener() {
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
      amount = amtController.text;
    } else if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.POSTPAID_KEY) {
      amount = totalAmountToPay();
    }
    _enterOtpBillPaymentsRequest.safeAdd(EnterOtpBillPaymentsUseCaseParams(
        billerType: billerType,
        amount: amount,
        currencyCode: currencyCode,
        accountNo: accountNo,
        isNewBiller: isNewBiller));
  }

  bool isAmountMoreThanZero = false;

  validate(String? value) {
    if (isDateOk == true) {
      isAmountMoreThanZero = false;
      if (double.parse(value ?? "0") > 0.0) {
        isAmountMoreThanZero = true; // if true :isAmountMoreThanZero key is to proceed with payPrepaid bill
        if (isPartial == true && isAmountInRange == true) {
          // if true :isAmountMoreThanZero key is to proceed with payPrepaid bill
          _showButtonSubject.safeAdd(true);
        } else if (isPartial == false && isAmountInRange == false) {
          _showButtonSubject.safeAdd(true);
        } else {
          _showButtonSubject.safeAdd(false);
        }
      } else {
        _showButtonSubject.safeAdd(false);
      }
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _validatePrePaidRequest.close();
    _validatePrePaidResponse.close();
    _payPrePaidRequest.close();
    _payPrePaidResponse.close();
    _postPaidBillEnquiryRequest.close();
    _postPaidBillEnquiryResponse.close();
    _payPostPaidRequest.close();
    _payPostPaidResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }

  /// edit amount field  subject
  BehaviorSubject<String> _editAmountFieldSubject = BehaviorSubject.seeded("");

  Stream<String> get minMaxErrorFieldStream => _editAmountFieldSubject.stream;
  bool isAmountInRange = false;

  void minMaxValidate(
      bool isPartial, String? minRange, String? maxRange, String value, BuildContext context) {
    if (isPartial == true) {
      isAmountInRange = false;
      if (double.parse(addAllBillAmt() ?? "0") != double.parse(dueAmtController ?? "0")) {
        value = (double.parse(dueAmtController ?? "0") + double.parse(feeAmtValue ?? "0")).toStringAsFixed(3);
      }
      if (value.isEmpty) {
        _editAmountFieldSubject.safeAdd(
            "${S.of(context).amountShouldBetween} ${minRange} ${S.of(context).JOD} ${S.of(context).to} ${maxRange} ${S.of(context).JOD}");
      } else if (double.parse(value) < double.parse(minRange ?? "0")) {
        _editAmountFieldSubject
            .safeAdd("${S.of(context).amountShouldBeMoreThan} ${minRange} ${S.of(context).JOD}");
      } else if (double.parse(value) > double.parse(maxRange ?? "0")) {
        if (double.parse(maxRange ?? "0") > 0.0) {
          _editAmountFieldSubject
              .safeAdd("${S.of(context).amountShouldBeLessThanOrEqualTo} ${maxRange} ${S.of(context).JOD}");
        } else {
          _editAmountFieldSubject.safeAdd("${S.of(context).thereAreNoDueBillsToBePaidAtTheMoment}");
        }
      } else {
        _editAmountFieldSubject.safeAdd("");
        isAmountInRange = true;
      }
    }
  }

  ///checkAmountMoreThanHundred
  bool checkAmountMoreThanHundred() {
    if (AppConstantsUtils.POST_PAID_FLOW == true) {
      return double.parse(totalAmountToPay() ?? "0") >= 100.0 ? true : false;
    }
    return double.parse(dueAmtController ?? "0") >= 100.0 ? true : false;
  }

  void amountGreaterThanZeroMessage(ConfirmBillPaymentAmountPageViewModel model) {
    if (AppConstantsUtils.POST_PAID_FLOW == true) {
      if (double.parse(model.totalAmountToPay() ?? "0") <= 0.0) {
        model.showToastWithError(AppError(
            cause: Exception(), error: ErrorInfo(message: ''), type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
      }
    } else {
      if (double.parse(model.dueAmtController ?? "0") <= 0.0) {
        model.showToastWithError(AppError(
            cause: Exception(), error: ErrorInfo(message: ''), type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
      }
    }
  }
}
