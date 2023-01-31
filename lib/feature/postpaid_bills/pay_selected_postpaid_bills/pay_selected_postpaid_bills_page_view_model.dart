import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/post_paid_bill_enquiry_request.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:domain/usecase/bill_payment/pay_post_paid_bill_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';

class PaySelectedBillsPostPaidBillsPageViewModel extends BasePageViewModel {
  final PaySelectedBillsPostPaidBillsPageArguments arguments;
  List<double> totalAmt = [];

  final ScrollController payingBillController = ScrollController();
  final TextEditingController savingAccountController = TextEditingController();

  PublishSubject<double> _totalBillAmtDueSubject = PublishSubject();

  Stream<double> get totalBillAmtDueStream => _totalBillAmtDueSubject.stream;

  final PayPostPaidBillUseCase payPostPaidBillUseCase;
  List<PostPaidBillInquiryData>? postPaidBillInquiryData = [];

  List<PostpaidBillInquiry>? tempPostpaidBillInquiryRequestList = [];

  PaySelectedBillsPostPaidBillsPageViewModel(this.payPostPaidBillUseCase, this.arguments) {
    payPostPaidBillListener();
  }

  bool isTotalAmountZero = true;
  double totalBillAmt = 0.0;
  int validRequestCounter = 0;

  addAllBillAmt(BuildContext context) async {
    totalBillAmt = 0.0;
    for (int index = 0; index < postPaidBillInquiryData!.length; index++) {
      PostPaidBillInquiryData inquiryData = postPaidBillInquiryData![index];
      if (inquiryData.dueAmount == null || inquiryData.dueAmount!.isEmpty) {
        totalBillAmt = await totalBillAmt + double.parse("0.0");
      } else {
        totalBillAmt = await totalBillAmt + double.parse(inquiryData.dueAmount ?? "0.0");
      }
    }
    isTotalAmountZero = totalBillAmt > 0.0 ? false : true;
    if (isTotalAmountZero) {
      showToastWithError(AppError(
          cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
    }
    validRequestCounter = 0;
    for (int index = 0; index < postPaidBillInquiryData!.length; index++) {
      PostPaidBillInquiryData inquiryData = postPaidBillInquiryData![index];
      if (inquiryData.minMaxValidationMessage != '') {
        validRequestCounter++;
      }
    }
    _totalBillAmtDueSubject.safeAdd(totalBillAmt);
  }

  /// ---------------- post paid data from allpostpaidbillsscreen -------------------------------- ///
  BehaviorSubject<List<PostPaidBillInquiryData>> _postPaidBillEnquiryListResponse = BehaviorSubject();

  Stream<List<PostPaidBillInquiryData>> get postPaidBillEnquiryListStream =>
      _postPaidBillEnquiryListResponse.stream;

  postpaidInquiryDataListener({required List<PostPaidBillInquiryData> list}) {
    _postPaidBillEnquiryListResponse.safeAdd(list);
  }

  /// ---------------- pay postPaid bill -------------------------------- ///
  PublishSubject<PayPostPaidBillUseCaseParams> _payPostPaidRequest = PublishSubject();

  BehaviorSubject<Resource<PayPostPaidBill>> _payPostPaidResponse = BehaviorSubject();

  Stream<Resource<PayPostPaidBill>> get payPostPaidStream => _payPostPaidResponse.stream;

  void payPostPaidBill(BuildContext context) {
    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("pay_post_paid_saved_bill", {"pay_post_paid_saved_bill_call": true});
    tempPostpaidBillInquiryRequestList = [];
    for (int i = 0; i < postPaidBillInquiryData!.length; i++) {
      PostPaidBillInquiryData item = postPaidBillInquiryData![i];

      if (double.parse(item.dueAmount ?? "0.0") > 0.0) {
        tempPostpaidBillInquiryRequestList?.add(PostpaidBillInquiry(
            billerCode: item.billerCode,
            billingNumber: item.billingNo,
            billerName: !StringUtils.isDirectionRTL(context)
                ? arguments.noOfSelectedBills[i].billerNameEN
                : arguments.noOfSelectedBills[i].billerNameAR,
            serviceType: item.serviceType,
            amount: double.parse(item.dueAmount ?? "0").toStringAsFixed(3),
            fees: item.feesAmt ?? "0.0"));
      }
    }
    tempPostpaidBillInquiryRequestList = tempPostpaidBillInquiryRequestList?.toSet().toList();
    addAllBillAmt(context);
    _payPostPaidRequest.safeAdd(PayPostPaidBillUseCaseParams(
        billerList: tempPostpaidBillInquiryRequestList,
        accountNo: savingAccountController.text,
        // need to confirm with mohit totalAmount must be taken and recalculate and shown from PostpaidBillInquiry data; as its showing from new bill page calculation
        totalAmount: totalBillAmt.toStringAsFixed(3),
        currencyCode: "JOD",
        isNewBiller: false,
        isCreditCardPayment: false,
        CardId: "",
        nickName: "",
        // only need to be added in case of new biller added request
        otpCode: ""));
  }

  void payPostPaidBillListener() {
    _payPostPaidRequest.listen(
      (params) {
        RequestManager(params, createCall: () => payPostPaidBillUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          //to do
          updateLoader();
          _payPostPaidResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            FireBaseLogUtil.fireBaseLog(
                "pay_post_paid_saved_bill_fail", {"pay_post_paid_saved_bill_fail": true});
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  void newAmtEnter(
    int index,
    String value,
    bool isPartial,
    String? minRange,
    String? maxRange,
    BuildContext context,
  ) {
    if (value.length <= 0) {
      value = "0";
    }
    arguments.postPaidBillInquiryData?[index].dueAmount = value;
    arguments.noOfSelectedBills[index].dueAmount = value;
    if (isPartial == true) {
      minMaxValidate(isPartial, minRange, maxRange, value, context, index);
    }

    // totalAmt[index] = double.parse(value);
    // arguments.noOfSelectedBills[index].dueAmount = value;
    // addAllBillAmt(context);
  }

  getValidBillerIcon(String? billingNumber, String? serviceType) {
    for (var item in arguments.noOfSelectedBills)
      if (item.billingNo == billingNumber && item.serviceType == serviceType) return item.iconCode;
  }

  getValidBillerNameEN(String? billingNumber, String? serviceType, BuildContext context) {
    for (var item in arguments.noOfSelectedBills) {
      if (item.billingNo == billingNumber && item.serviceType == serviceType) {
        if (StringUtils.isDirectionRTL(context)) {
          return item.billerNameAR != null && item.billerNameAR!.isNotEmpty ? item.billerNameAR : "";
        } else
          return item.billerNameEN != null && item.billerNameEN!.isNotEmpty ? item.billerNameEN : "";
      }
    }
  }

  getValidBillerNickName(String? billingNumber, String? serviceType) {
    for (var item in arguments.noOfSelectedBills) {
      if (item.billingNo == billingNumber && item.serviceType == serviceType)
        return item.nickName != null && item.nickName!.isNotEmpty ? item.nickName : "";
    }
  }

  /* getValidBillerServiceTypeDescEN(String? billingNumber) {
    for (var item in arguments.noOfSelectedBills)
      if (item.billingNo == billingNumber)
        return item.serviceTypeDescEN != null &&
                item.serviceTypeDescEN!.isNotEmpty
            ? item.serviceTypeDescEN
            : null;
  }*/

  getValidBillerDueAmount(String? billingNumber, String? serviceType) {
    for (var item in arguments.noOfSelectedBills)
      if (item.billingNo == billingNumber && item.serviceType == serviceType)
        return item.dueAmount != null && item.dueAmount!.isNotEmpty
            ? double.parse(item.dueAmount ?? "0").toStringAsFixed(3)
            : "0.0";
  }

  getValidBillerBillingNumber(String? billingNumber, String? serviceType) {
    for (var item in arguments.noOfSelectedBills)
      if (item.billingNo == billingNumber && item.serviceType == serviceType)
        return item.billingNo != null && item.billingNo!.isNotEmpty ? item.billingNo : "";
  }

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  validate() {
    if (isTotalAmountZero == false && savingAccountController.text.isNotEmpty && validRequestCounter == 0) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void minMaxValidate(
      bool isPartial, String? minRange, String? maxRange, String value, BuildContext context, int index) {
    if (isPartial == true) {
      if (value.isEmpty) {
        arguments.postPaidBillInquiryData?[index].minMaxValidationMessage =
            "${S.of(context).amountShouldBetween} ${minRange} ${S.of(context).JOD} ${S.of(context).to} ${maxRange} ${S.of(context).JOD}";
      } else if (double.parse(value) < double.parse(minRange ?? "0")) {
        arguments.postPaidBillInquiryData?[index].minMaxValidationMessage =
            "${S.of(context).amountShouldBeMoreThan} ${minRange} ${S.of(context).JOD}";
      } else if (double.parse(value) > double.parse(maxRange ?? "0")) {
        arguments.postPaidBillInquiryData?[index].minMaxValidationMessage =
            "${S.of(context).amountShouldBeLessThanOrEqualTo} ${maxRange} ${S.of(context).JOD}";
      } else {
        arguments.postPaidBillInquiryData?[index].minMaxValidationMessage = "";
      }
    }
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _totalBillAmtDueSubject.close();
    _payPostPaidResponse.close();
    _payPostPaidRequest.close();
    super.dispose();
  }
}
