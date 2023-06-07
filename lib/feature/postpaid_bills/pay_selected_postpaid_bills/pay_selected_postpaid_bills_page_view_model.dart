import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/post_paid_bill_enquiry_request.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/biller_success.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:domain/usecase/bill_payment/pay_post_paid_bill_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
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
  final ScrollController payingBillController = ScrollController();
  final TextEditingController savingAccountController = TextEditingController();

  PublishSubject<double> _totalBillAmtDueSubject = PublishSubject();

  Stream<double> get totalBillAmtDueStream => _totalBillAmtDueSubject.stream;

  final PayPostPaidBillUseCase payPostPaidBillUseCase;
  List<PostPaidBillInquiryData>? postPaidBillInquiryData = [];

  List<PostpaidBillInquiry>? tempPostpaidBillInquiryRequestList = [];

  List<BillerSuccessDetails>? billerSuccessDetailsList = [];

  PaySelectedBillsPostPaidBillsPageViewModel(this.payPostPaidBillUseCase, this.arguments) {
    payPostPaidBillListener();
  }

  bool isTotalAmountZero = true;
  double totalBillAmt = 0.0;
  double totalBillAmtSuccess = 0.0;
  int validRequestCounter = 0;

  addAllBillAmt(BuildContext context, {isApi = false}) async {
    totalBillAmt = 0.0;
    totalBillAmtSuccess = 0.0;
    for (int index = 0; index < postPaidBillInquiryData!.length; index++) {
      PostPaidBillInquiryData inquiryData = postPaidBillInquiryData![index];
      if (inquiryData.dueAmount == null || inquiryData.dueAmount!.isEmpty) {
        totalBillAmt = await totalBillAmt + double.parse("0.0");
      } else {
        if (inquiryData.isPartial == true &&
            double.parse(inquiryData.dueAmount ?? "0") !=
                double.parse(inquiryData.actualDueAmountFromApi ?? "0")) {
          if (isApi == false) {
            totalBillAmt = await totalBillAmt +
                double.parse(inquiryData.dueAmount ?? "0.0") +
                double.parse(inquiryData.feesAmt ?? "0.0");
          } else {
            totalBillAmt = await totalBillAmt + double.parse(inquiryData.dueAmount ?? "0.0");
          }
        } else {
          totalBillAmt = await totalBillAmt + double.parse(inquiryData.dueAmount ?? "0.0");
        }
      }
    }
    isTotalAmountZero = await totalBillAmt > 0.0 ? false : true;
    if (isTotalAmountZero) {
      showToastWithError(AppError(
          cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
    }
    validRequestCounter = 0;
    for (int index = 0; index < postPaidBillInquiryData!.length; index++) {
      PostPaidBillInquiryData inquiryData = postPaidBillInquiryData![index];
      if (inquiryData.minMaxValidationMessage != '') {
        await validRequestCounter++;
      }
    }
    totalBillAmtSuccess = await totalBillAmt;
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

  Future<void> payPostPaidBill(BuildContext context) async {
    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("pay_post_paid_saved_bill", {"pay_post_paid_saved_bill_call": true});
    tempPostpaidBillInquiryRequestList = [];
    billerSuccessDetailsList = [];
    for (int i = 0; i < postPaidBillInquiryData!.length; i++) {
      PostPaidBillInquiryData item = postPaidBillInquiryData![i];

      if (double.parse(item.dueAmount ?? "0.0") > 0.0) {
        tempPostpaidBillInquiryRequestList?.add(PostpaidBillInquiry(
            billerCode: item.billerCode,
            billingNumber: item.billingNo,
            billingNo: item.billingNo,
            billerName: !StringUtils.isDirectionRTL(context)
                ? arguments.noOfSelectedBills[i].billerNameEN
                : arguments.noOfSelectedBills[i].billerNameAR,
            serviceType: item.serviceType,
            nickName: getValidBillerNickName(item.billingNo, item.serviceType),
            amount: double.parse(item.dueAmount ?? "0").toStringAsFixed(3),
            dueAmount: double.parse(item.actualDueAmountFromApi ?? "0").toStringAsFixed(3),
            fees: item.feesAmt ?? "0.0",
            inqRefNo: item.inqRefNo ?? "",
            isPartialAllowed: item.isPartial ?? false));
      }
      billerSuccessDetailsList?.add(BillerSuccessDetails(
        billerName: !StringUtils.isDirectionRTL(context)
            ? arguments.noOfSelectedBills[i].billerNameEN
            : arguments.noOfSelectedBills[i].billerNameAR,
        dueAmount: checkAndGetValidBillerDueAmount(item.billingNo, item.serviceType),
        fee: item.feesAmt ?? "0.0",
        serviceType: !StringUtils.isDirectionRTL(context)
            ? arguments.noOfSelectedBills[i].serviceType
            : arguments.noOfSelectedBills[i].serviceTypeAR,
      ));
    }
    tempPostpaidBillInquiryRequestList = tempPostpaidBillInquiryRequestList?.toSet().toList();
    await addAllBillAmt(context, isApi: true);
    if (totalBillAmt > 0) {
      if (double.parse(ProviderScope.containerOf(context)
                  .read(appHomeViewModelProvider)
                  .dashboardDataContent
                  .account
                  ?.availableBalance ??
              '-1') >=
          totalBillAmt) {
        Future.delayed(Duration(milliseconds: 200))
            .then((value) => _payPostPaidRequest.safeAdd(PayPostPaidBillUseCaseParams(
                billerList: tempPostpaidBillInquiryRequestList,
                accountNo: savingAccountController.text,
                totalAmount: totalBillAmt.toStringAsFixed(3),
                currencyCode: "JOD",
                isNewBiller: false,
                isCreditCardPayment: false,
                CardId: "",
                nickName: "",
                // only need to be added in case of new biller added request
                otpCode: "")));
      } else {
        showToastWithError(AppError(
            cause: Exception(),
            error: ErrorInfo(message: ''),
            type: ErrorType.INSUFFICIENT_FUNDS_BILL_CANNOT_BE_PAYED));
      }
    }
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
    String actualDueAmountFromApi,
    String feeAmt,
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
      if (double.parse(value) != double.parse(actualDueAmountFromApi)) {
        value = (double.parse(value).toStringAsFixed(3)); /*+ double.parse(feeAmt)).toStringAsFixed(3)*/
      }
      minMaxValidate(isPartial, minRange, maxRange, value, actualDueAmountFromApi, feeAmt, context, index);
    }
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

  getValidBillerDueAmount(String? billingNumber, String? serviceType) {
    for (var item in arguments.noOfSelectedBills)
      if (item.billingNo == billingNumber && item.serviceType == serviceType) {
        return item.dueAmount != null && item.dueAmount!.isNotEmpty
            ? double.parse(item.dueAmount ?? "0").toStringAsFixed(3)
            : "0.0";
      }
  }

  checkAndGetValidBillerDueAmount(String? billingNumber, String? serviceType) {
    for (var item in arguments.noOfSelectedBills) {
      if (item.billingNo == billingNumber && item.serviceType == serviceType) {
        if (double.parse(getValidBillerDueAmount(billingNumber, serviceType) ?? "0") ==
            double.parse(getValidBillerActualDueAmount(billingNumber, serviceType) ?? "0")) {
          return double.parse('${double.parse(item.dueAmount ?? "0.0") - double.parse(item.fees ?? "0.0")}')
              .toStringAsFixed(3);
        } else
          return item.dueAmount != null && item.dueAmount!.isNotEmpty
              ? double.parse(item.dueAmount ?? "0").toStringAsFixed(3)
              : double.parse("0").toStringAsFixed(3);
      }
    }
  }

  getValidBillerActualDueAmount(String? billingNumber, String? serviceType) {
    for (var item in arguments.noOfSelectedBills)
      if (item.billingNo == billingNumber && item.serviceType == serviceType)
        return item.actualdueAmountFromApi != null && item.actualdueAmountFromApi!.isNotEmpty
            ? double.parse(item.actualdueAmountFromApi ?? "0").toStringAsFixed(3)
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

  void minMaxValidate(bool isPartial, String? minRange, String? maxRange, String value,
      String actualDueAmountFromApi, String feeAmt, BuildContext context, int index) {
    if (isPartial == true) {
      if (value.isEmpty) {
        arguments.postPaidBillInquiryData?[index].minMaxValidationMessage =
            "${S.of(context).amountShouldBetween} ${minRange} ${S.of(context).JOD} ${S.of(context).to} ${maxRange} ${S.of(context).JOD}";
      } else if (double.parse(value) < double.parse(minRange ?? "0")) {
        arguments.postPaidBillInquiryData?[index].minMaxValidationMessage =
            "${S.of(context).amountShouldBeMoreThan} ${minRange} ${S.of(context).JOD}";
      } else if (double.parse(value) > double.parse(maxRange ?? "0")) {
        if (double.parse(maxRange ?? "0") > 0.0) {
          arguments.postPaidBillInquiryData?[index].minMaxValidationMessage =
              "${S.of(context).amountShouldBeLessThanOrEqualTo} ${maxRange} ${S.of(context).JOD}";
        } else {
          arguments.postPaidBillInquiryData?[index].minMaxValidationMessage =
              "${S.of(context).thereAreNoDueBillsToBePaidAtTheMoment}";
        }
      } else {
        arguments.postPaidBillInquiryData?[index].minMaxValidationMessage = "";
      }
    }
  }

  void onChangedCalled(int index, String value, BuildContext context) {
    newAmtEnter(
      index,
      value,
      double.parse(postPaidBillInquiryData?[index].actualDueAmountFromApi ?? "0").toStringAsFixed(3),
      double.parse(postPaidBillInquiryData?[index].feesAmt ?? "0").toStringAsFixed(3),
      postPaidBillInquiryData?[index].isPartial ?? false,
      double.parse(postPaidBillInquiryData?[index].minValue ?? "0").toStringAsFixed(3),
      double.parse(postPaidBillInquiryData?[index].maxValue ?? "0").toStringAsFixed(3),
      context,
    );
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
