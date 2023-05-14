import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/base/base_response.dart';
import 'package:data/entity/remote/bill_payment/add_new_postpaid_biller/add_new_postpaid_biller_entity_request.dart';
import 'package:data/entity/remote/bill_payment/add_new_prepaid_biller/add_new_prepaid_biller_entity_request.dart';
import 'package:data/entity/remote/bill_payment/bill_payments_transactions/bill_payments_transaction_request.dart';
import 'package:data/entity/remote/bill_payment/bill_payments_transactions/bill_payments_transaction_response.dart';
import 'package:data/entity/remote/bill_payment/get_bill_categories/get_bill_categories_entity.dart';
import 'package:data/entity/remote/bill_payment/get_bill_categories/get_biller_categories_request_entity.dart';
import 'package:data/entity/remote/bill_payment/get_biller_lookup_List/get_biller_lookup_list_request.dart';
import 'package:data/entity/remote/bill_payment/get_biller_lookup_List/get_biller_lookup_list_response.dart';
import 'package:data/entity/remote/bill_payment/get_postpaid_biller_list/get_postpaid_biller_list_entity_response.dart';
import 'package:data/entity/remote/bill_payment/get_pre_paid_categories/get_pre_paid_categories_response.dart';
import 'package:data/entity/remote/bill_payment/get_pre_paid_categories/get_prepaid_categories_request_entity.dart';
import 'package:data/entity/remote/bill_payment/get_prepaid_biller_list/get_prepaid_biller_list_entity_response.dart';
import 'package:data/entity/remote/bill_payment/pay_post_paid_bill/pay_post_paid_bill_request_entity.dart';
import 'package:data/entity/remote/bill_payment/pay_post_paid_bill/pay_post_paid_bill_response.dart';
import 'package:data/entity/remote/bill_payment/pay_prepaid_bill/pay_prepaid_bill_request.dart';
import 'package:data/entity/remote/bill_payment/pay_prepaid_bill/pay_prepaid_bill_response.dart';
import 'package:data/entity/remote/bill_payment/post_paid_bill_inquiry/post_paid_bill_inquiry_request_entity.dart';
import 'package:data/entity/remote/bill_payment/post_paid_bill_inquiry/post_paid_bill_inquiry_response.dart';
import 'package:data/entity/remote/bill_payment/remove_customer_billing/remove_customer_billing_request.dart';
import 'package:data/entity/remote/bill_payment/remove_prepaid_biller/remove_prepaid_biller_request.dart';
import 'package:data/entity/remote/bill_payment/validate_biller_otp/validate_biller_otp_request.dart';
import 'package:data/entity/remote/bill_payment/validate_biller_otp/validate_biller_otp_response.dart';
import 'package:data/entity/remote/bill_payment/validate_prepaid_biller/validate_pre_paid_bill_request_entity.dart';
import 'package:data/entity/remote/bill_payment/validate_prepaid_biller/validate_pre_paid_bill_response.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/bill_payment/bill_payment_data_source.dart';
import 'package:domain/usecase/bill_payment/add_new_postpaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/add_new_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/bill_payments_transaction_usecase.dart';
import 'package:domain/usecase/bill_payment/enter_otp_bill_paymnets_usecase.dart';
import 'package:domain/usecase/bill_payment/get_biller_lookup_list_usecase.dart';
import 'package:domain/usecase/bill_payment/get_postpaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_prepaid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_customer_billing_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/validate_prepaid_bill_usecase.dart';
import 'package:retrofit/retrofit.dart';

class BillPaymentRemoteDSImpl extends BillPaymentRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  BillPaymentRemoteDSImpl(
    this._apiService,
    this._deviceInfoHelper,
  );

  @override
  Future<HttpResponse<GetBillCategoriesEntity>> getBillCategories({required String type}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getBillCategories(
        GetBillerCategoriesRequestEntity(getToken: true, type: type, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<GetPostpaidBillerListEntityResponse>> getPostpaidBillerList(
      {required GetPostpaidBillerListUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getPostpaidBillerListData(BaseRequest(baseData: baseData.toJson()));
  }

  Future<HttpResponse<GetPrepaidBillerListEntityResponse>> getPrepaidBillerListResponse(
      {required GetPrepaidBillerListUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.getPrepaidBillerListData(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<GetPrepaidBillerListEntityResponse>> getPrepaidBillerList(
      {required GetPrepaidBillerListUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.getPrepaidBillerListData(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<PayPrePaidResponse>> payPrepaidBillDs({PayPrePaidUseCaseParams? params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.payPrePaidBillData(PayPrePaidRequest(
        billerCode: params?.billerCode,
        billerName: params?.billerName,
        billingNumber: params?.billingNumber,
        serviceType: params?.serviceType,
        amount: params?.amount,
        fees: params?.fees,
        currencyCode: params?.currencyCode,
        accountNo: params?.accountNo,
        isNewBiller: params?.isNewBiller,
        otpCode: params?.otpCode,
        validationCode: params?.validationCode,
        CardId: params?.CardId,
        nickName: params?.nickName,
        prepaidCategoryCode: params?.prepaidCategoryCode,
        prepaidCategoryType: params?.prepaidCategoryType,
        billingNumberRequired: params?.billingNumberRequired,
        isCreditCardPayment: params?.isCreditCardPayment,
        getToken: true,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<PayPostPaidBillResponse>> payPostPaidBill({required params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    if (params.CardId == "NewPostPaid") {
      return _apiService.payPostPaidBill(PayPostPaidBillRequestEntity(
          accountNo: params.accountNo,
          billerList: params.billerList,
          currencyCode: params.currencyCode,
          isNewBiller: params.isNewBiller,
          otpCode: params.otpCode,
          CardId: "",
          nickName: params.nickName,
          isCreditCardPayment: params.isCreditCardPayment,
          totalAmount: params.totalAmount,
          getToken: true,
          baseData: baseData.toJson()));
    }

    return _apiService.payPostPaidBillV1(PayPostPaidBillRequestEntity(
        accountNo: params.accountNo,
        billerList: params.billerList,
        currencyCode: params.currencyCode,
        isNewBiller: params.isNewBiller,
        otpCode: params.otpCode,
        CardId: "",
        nickName: params.nickName,
        isCreditCardPayment: params.isCreditCardPayment,
        totalAmount: params.totalAmount,
        getToken: true,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<BaseResponse>> addNewPostpaidBiller(
      {required AddNewPostpaidBillerUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.addNewPostpaidBillerData(
      AddNewPostpaidBillerEntityRequest(
          serviceType: params.serviceType,
          billerCode: params.billerCode,
          billingNumber: params.billingNumber,
          nickname: params.nickname,
          getToken: true,
          baseData: baseData.toJson()),
    );
  }

  @override
  Future<HttpResponse<ValidatePrePaidBillResponse>> validatePrePaidBill(
      {required ValidatePrePaidUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.validatePrePaidBill(ValidatePrePaidBillRequestEntity(
        billerCode: params.billerCode,
        amount: params.amount,
        serviceType: params.serviceType,
        billingNumber: params.billingNumber,
        prepaidCategoryCode: params.prepaidCategoryCode,
        prepaidCategoryType: params.prepaidCategoryType,
        billingNumberRequired: params.billingNumberRequired,
        getToken: true,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<PostPaidBillInquiryResponse>> postPaidBillInquiry({required params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.postPaidBillInquiry(PostPaidBillInquiryRequestEntity(
        postpaidBillInquiries: params.postpaidBillInquiries, getToken: true, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<BaseResponse>> addNewPrepaidBiller(
      {required AddNewPrepaidBillerUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.addNewPrepaidBillerData(
      AddNewPrepaidBillerEntityRequest(
          prepaidCategoryType: params.prepaidCategoryType,
          prepaidCategoryCode: params.prepaidCategoryCode,
          serviceType: params.serviceType,
          serviceCode: params.serviceCode,
          billerCode: params.billerCode,
          billerName: params.billerName,
          billingNumber: params.billingNumber,
          nickname: params.nickname,
          amount: params.amount,
          billingNumberRequired: params.billingNumberRequired,
          getToken: true,
          baseData: baseData.toJson()),
    );
  }

  @override
  Future<HttpResponse<GetBillerLookupListResponse>> getBillerLookuplist(
      {required GetBillerLookupUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.getBillerLookupList(GetBillerLookupListRequest(
        categoryName: params.categoryName,
        // categoryNameAr: params.categoryNameAr, // might need in future
        type: params.type,
        getToken: true,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<GetPrePaidCategoriesResponse>> getPrePaidCategories(
      {required GetPrePaidCategoriesListUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.getPrePaidCategory(GetPrePaidCategoriesRequestEntity(
        billerCode: params.billerCode,
        serviceCode: params.serviceCode,
        getToken: true,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<BaseResponse>> removeCustomerBilling({
    required RemoveCustomerBillingUseCaseParams params,
  }) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.removeCustomerBilling(
      RemoveCustomerBillingRequest(
          billerCode: params.billerCode,
          billingNo: params.billingNo,
          serviceType: params.serviceType,
          getToken: true,
          baseData: baseData.toJson()),
    );
  }

  @override
  Future<HttpResponse<BaseResponse>> removePrepaidBiller({
    required RemovePrepaidBillerUseCaseParams params,
  }) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.removePrepaidBiller(
      RemovePrepaidBillerRequest(
          registrationID: params.registrationID, getToken: true, baseData: baseData.toJson()),
    );
  }

  @override
  Future<HttpResponse<ResponseEntity>> cliqRegisterCustomer() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.cliqRegisterCustomer(BaseRequest(baseData: baseData.toJson(), getToken: false));
  }

  @override
  Future<HttpResponse<ResponseEntity>> cliqRegisterAccount() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.cliqRegisterAccount(BaseRequest(baseData: baseData.toJson(), getToken: false));
  }

  @override
  Future<HttpResponse<ResponseEntity>> accountUpload() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.accountUpload(BaseRequest(baseData: baseData.toJson(), getToken: false));
  }

  @override
  Future<HttpResponse<ValidateBillerOtpResponse>> validateBillerOtp(
      {required EnterOtpBillPaymentsUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.validateBillerOtp(
      ValidateBillerOtpRequest(
          billerType: params.billerType,
          billerName: params.billerName,
          amount: params.amount,
          currencyCode: params.currencyCode,
          accountNo: params.accountNo,
          isNewBiller: params.isNewBiller,
          getToken: true,
          baseData: baseData.toJson()),
    );
  }

  @override
  Future<HttpResponse<BillPaymentsTransactionResponse>> billPaymentsTransactionHistory(
      {required BillPaymentsTransactionUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.getBillPaymentsTransactions(
      BillPaymentsTransactionRequest(
          type: params.type,
          pageSize: params.pageSize,
          pageNo: params.pageNo,
          searchText: params.searchText,
          getToken: true,
          baseData: baseData.toJson()),
    );
  }
}
