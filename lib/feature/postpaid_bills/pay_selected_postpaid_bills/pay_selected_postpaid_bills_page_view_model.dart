import 'package:domain/model/bill_payments/get_postpaid_biller_list/post_paid_bill_enquiry_request.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:domain/usecase/bill_payment/pay_post_paid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/post_paid_bill_inquiry_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PaySelectedBillsPostPaidBillsPageViewModel extends BasePageViewModel {
  final PaySelectedBillsPostPaidBillsPageArguments arguments;
  List<double> totalAmt = [];

  final ScrollController payingBillController = ScrollController();
  final TextEditingController savingAccountController = TextEditingController();

  PublishSubject<double> _totalBillAmtDueSubject = PublishSubject();

  Stream<double> get totalBillAmtDueStream => _totalBillAmtDueSubject.stream;

  final PostPaidBillInquiryUseCase postPaidBillInquiryUseCase;
  final PayPostPaidBillUseCase payPostPaidBillUseCase;
  List<PostPaidBillInquiryData>? postPaidBillInquiryData = [];

  List<PostpaidBillInquiry>? tempPostpaidBillInquiryRequestList = [];

  PaySelectedBillsPostPaidBillsPageViewModel(this.postPaidBillInquiryUseCase,
      this.payPostPaidBillUseCase, this.arguments) {
    Future.delayed(Duration(milliseconds: 10))
        .then((value) => postpaidInquiryDataListener());
    // postPaidBillInquiryListener();
    payPostPaidBillListener();
  }

  double addAllBillAmt() {
    double totalBillAmt = 0.0;
    arguments.noOfSelectedBills.forEach((element) {
      if (element.isChecked == true) {
        totalBillAmt = double.parse(element.dueAmount ?? "0.0") + totalBillAmt;
      }
    });
    return totalBillAmt;
  }

  /// ---------------- post paid data from allpostpaidbillsscreen -------------------------------- ///
  BehaviorSubject<List<PostPaidBillInquiryData>>
      _postPaidBillEnquiryListResponse = BehaviorSubject();

  Stream<List<PostPaidBillInquiryData>> get postPaidBillEnquiryListStream =>
      _postPaidBillEnquiryListResponse.stream;

  postpaidInquiryDataListener() {
    _postPaidBillEnquiryListResponse.safeAdd(arguments.postPaidBillInquiryData);
  }

  /// ---------------- post paid bill enquiry -------------------------------- ///
  PublishSubject<PostPaidBillInquiryUseCaseParams> _postPaidBillEnquiryRequest =
      PublishSubject();

  BehaviorSubject<Resource<PostPaidBillInquiry>> _postPaidBillEnquiryResponse =
      BehaviorSubject();

  Stream<Resource<PostPaidBillInquiry>> get postPaidBillEnquiryStream =>
      _postPaidBillEnquiryResponse.stream;

  void postPaidBillInquiry() {
    _postPaidBillEnquiryRequest.safeAdd(PostPaidBillInquiryUseCaseParams(
        postpaidBillInquiries: arguments.postPaidRequestListJson));
  }

  void postPaidBillInquiryListener() {
    _postPaidBillEnquiryRequest.listen(
      (params) {
        RequestManager(params,
                createCall: () =>
                    postPaidBillInquiryUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _postPaidBillEnquiryResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showErrorState();
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {
            postPaidBillInquiryData =
                event.data?.content?.postPaidBillInquiryData;
          }
        });
      },
    );
  }

  /// ---------------- pay prepaid bill -------------------------------- ///
  PublishSubject<PayPostPaidBillUseCaseParams> _payPostPaidRequest =
      PublishSubject();

  BehaviorSubject<Resource<PayPostPaidBill>> _payPostPaidResponse =
      BehaviorSubject();

  Stream<Resource<PayPostPaidBill>> get payPostPaidStream =>
      _payPostPaidResponse.stream;

  void payPostPaidBill() {
    tempPostpaidBillInquiryRequestList = [];
    for (int i = 0; i < postPaidBillInquiryData!.length; i++) {
      PostPaidBillInquiryData item = postPaidBillInquiryData![i];

      if (double.parse(item.dueAmount ?? "0.0") > 0.0) {
        tempPostpaidBillInquiryRequestList?.add(PostpaidBillInquiry(
            billerCode: item.billerCode,
            billingNumber: /*"121344"*/ item.billingNo,
            billerName: arguments.noOfSelectedBills[i].billerNameEN,
            serviceType: item.serviceType,
            amount: /*"20.0"*/ item.dueAmount,
            fees: item.feesAmt ?? "0.0"));
      }
    }
    tempPostpaidBillInquiryRequestList =
        tempPostpaidBillInquiryRequestList?.toSet().toList();
    _payPostPaidRequest.safeAdd(PayPostPaidBillUseCaseParams(
        billerList: tempPostpaidBillInquiryRequestList,
        accountNo: savingAccountController.text,
        // need to confirm with mohit totalAmount must be taken and recalculate and shown from PostpaidBillInquiry data; as its showing from new bill page calculation
        totalAmount: addAllBillAmt().toString(),
        currencyCode: "JOD",
        isNewBiller: false,
        isCreditCardPayment: /* cardType != null &&
            cardType.isNotEmpty &&
            cardType == AppConstants.KEY_CREDIT
            ? true
            : */
            false,
        CardId: /*cardType != null &&
            cardType.isNotEmpty &&
            cardType == AppConstants.KEY_CREDIT
            ? cardID
            :*/
            "",
        otpCode: ""));
  }

  void payPostPaidBillListener() {
    _payPostPaidRequest.listen(
      (params) {
        RequestManager(params,
                createCall: () =>
                    payPostPaidBillUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          //to do
          updateLoader();
          _payPostPaidResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  void newAmtEnter(int index, String value) {
    if (value.length <= 0) {
      value = "0";
    }
    // totalAmt[index] = double.parse(value);
    arguments.noOfSelectedBills[index].dueAmount = value;
    _totalBillAmtDueSubject.safeAdd(addAllBillAmt());
  }

  bool isTotalAmountZero = true;

  String getTotalAmountList(final List<PostPaidBillInquiryData>? list) {
    double totalAmount = 0.0;
    isTotalAmountZero = true;
    for (var item in list!) {
      totalAmount = totalAmount +
          double.parse(getTotalAmountItemWise(item.dueAmount, item.feesAmt));
    }
    if (totalAmount > 0) isTotalAmountZero = false;
    return '${totalAmount.toString()}';
  }

  String getTotalAmountItemWise(String? due, String? fees) {
    double dueAmount = due == null ? 0.0 : double.parse(due);
    double feesAmount = fees == null ? 0.0 : double.parse(fees);
    return '${dueAmount}';
    // return '${AppAmountFormatter.formatByCurrencyWithOutComma((dueAmount /*+ feesAmount*/).toString(), currency: "JOD")}';
  }

  getValidBillerIcon(String? billingNumber) {
    for (var item in arguments.noOfSelectedBills)
      if (item.billingNo == billingNumber) return item.iconCode;
  }

  getValidBillerNameEN(String? billingNumber) {
    for (var item in arguments.noOfSelectedBills) {
      if (item.billingNo == billingNumber)
        return item.billerNameEN != null && item.billerNameEN!.isNotEmpty
            ? item.billerNameEN
            : "";
    }
  }

  getValidBillerNickName(String? billingNumber, {String? nickName}) {
    for (var item in arguments.noOfSelectedBills) {
      if (item.billingNo == billingNumber)
        return nickName != null && nickName.isNotEmpty ? nickName : "";
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

  getValidBillerDueAmount(String? billingNumber) {
    for (var item in arguments.noOfSelectedBills)
      if (item.billingNo == billingNumber)
        return item.dueAmount != null && item.dueAmount!.isNotEmpty
            ? double.parse(item.dueAmount ?? "0").toStringAsFixed(3)
            : "0.0";
  }

  getValidBillerBillingNumber(String? billingNumber) {
    for (var item in arguments.noOfSelectedBills)
      if (item.billingNo == billingNumber)
        return item.billingNo != null && item.billingNo!.isNotEmpty
            ? item.billingNo
            : "";
  }

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  var totalAmount = "0.0";

  validate() {
    totalAmount = addAllBillAmt().toString();
    if (double.parse(totalAmount) > 0.0) {
      if (savingAccountController.text.isNotEmpty) {
        _showButtonSubject.safeAdd(true);
      }
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _totalBillAmtDueSubject.close();
    _postPaidBillEnquiryResponse.close();
    _postPaidBillEnquiryResponse.close();
    _payPostPaidResponse.close();
    _payPostPaidRequest.close();
    super.dispose();
  }
}
