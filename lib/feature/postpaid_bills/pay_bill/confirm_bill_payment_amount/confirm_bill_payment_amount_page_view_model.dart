import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_details_bill_paymemts_model.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/post_paid_bill_enquiry_request.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:domain/usecase/bill_payment/pay_post_paid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_prepaid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/post_paid_bill_inquiry_usecase.dart';
import 'package:domain/usecase/bill_payment/validate_prepaid_bill_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
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
  bool isPartial = false;
  String? minRange = "0";
  String? maxRange = "0";

  String? otpCode = "";
  bool? isNewBiller = false;

  ConfirmBillPaymentAmountPageViewModel(this.validatePrePaidUseCase, this.payPrePaidUseCase,
      this.postPaidBillInquiryUseCase, this.payPostPaidBillUseCase) {
    validatePrePaidBillListener();
    payPrePaidBillListener();
    postPaidBillInquiryListener();
    payPostPaidBillListener();
  }

  TextEditingController amtController = TextEditingController(text: "0.0");
  TextEditingController feeAmtController = TextEditingController(text: "0.0");

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
        billingNumber: AppConstantsUtils.SELECTED_BILLING_NUMBER));

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
            billerName: AppConstantsUtils.BILLER_NAME,
            serviceType: item.serviceType,
            amount: totalAmountToPay(),
            fees: item.feesAmt ?? "0.0"));
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
        CardId: "",
        otpCode: ""));
  }

  addAllBillAmt() {
    var totalBillAmt = 0.0;
    postPaidBillInquiryData!.forEach((element) {
      totalBillAmt = double.parse(element.dueAmount ?? "0.0") + totalBillAmt;
    });
    return totalBillAmt.toStringAsFixed(3);
  }

  totalAmountToPay() {
    if (isPartial == true) {
      if (double.parse(addAllBillAmt() ?? "0") != double.parse(amtController.text)) {
        return double.parse(amtController.text).toStringAsFixed(3);
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
        amount: addNewBillDetailsData.isPrepaidCategoryListEmpty == true ? amtController.text : "",
        currencyCode: "JOD",
        accountNo: addNewBillDetailsData.accountNumber,
        otpCode: otpCode,
        isNewBiller: isNewBiller,
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

  bool isAmountMoreThanZero = false;

  validate(String value) {
    isAmountMoreThanZero = false;
    if (double.parse(value) > 0.0) {
      isAmountMoreThanZero = true;
      _showButtonSubject.safeAdd(true);
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
}
