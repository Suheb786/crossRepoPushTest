import 'package:data/entity/remote/base/base_response.dart';
import 'package:data/entity/remote/bill_payment/get_bill_categories/get_bill_categories_entity.dart';
import 'package:data/entity/remote/bill_payment/get_pre_paid_categories/get_pre_paid_categories_response.dart';
import 'package:data/entity/remote/bill_payment/get_pre_paid_categories/get_prepaid_categories_request_entity.dart';
import 'package:data/entity/remote/bill_payment/pay_post_paid_bill/pay_post_paid_bill_request_entity.dart';
import 'package:data/entity/remote/bill_payment/pay_post_paid_bill/pay_post_paid_bill_response.dart';
import 'package:data/entity/remote/bill_payment/pay_prepaid_bill/pay_prepaid_bill_request.dart';
import 'package:data/entity/remote/bill_payment/pay_prepaid_bill/pay_prepaid_bill_response.dart';
import 'package:data/entity/remote/bill_payment/post_paid_bill_inquiry/post_paid_bill_inquiry_request_entity.dart';
import 'package:data/entity/remote/bill_payment/post_paid_bill_inquiry/post_paid_bill_inquiry_response.dart';
import 'package:data/entity/remote/bill_payment/remove_customer_billing/remove_customer_billing_request.dart';
import 'package:data/entity/remote/bill_payment/remove_prepaid_biller/remove_prepaid_biller_request.dart';
import 'package:data/entity/remote/bill_payment/validate_prepaid_biller/validate_pre_paid_bill_request_entity.dart';
import 'package:data/entity/remote/bill_payment/validate_prepaid_biller/validate_pre_paid_bill_response.dart';
import 'package:data/network/api_service.dart';
import 'package:domain/usecase/bill_payment/add_new_postpaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/add_new_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/get_biller_lookup_list_usecase.dart';
import 'package:domain/usecase/bill_payment/get_postpaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_prepaid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_customer_billing_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/validate_prepaid_bill_usecase.dart';
import 'package:retrofit/retrofit.dart';

import '../../../entity/remote/bill_payment/add_new_postpaid_biller/add_new_postpaid_biller_entity_request.dart';
import '../../../entity/remote/bill_payment/add_new_postpaid_biller/add_new_postpaid_biller_entity_response.dart';
import '../../../entity/remote/bill_payment/add_new_prepaid_biller/add_new_prepaid_biller_entity_request.dart';
import '../../../entity/remote/bill_payment/add_new_prepaid_biller/add_new_prepaid_biller_entity_response.dart';
import '../../../entity/remote/bill_payment/get_biller_lookup_List/get_biller_lookup_list_request.dart';
import '../../../entity/remote/bill_payment/get_biller_lookup_List/get_biller_lookup_list_response.dart';
import '../../../entity/remote/bill_payment/get_postpaid_biller_list/get_postpaid_biller_list_entity_response.dart';
import '../../../entity/remote/bill_payment/get_prepaid_biller_list/get_prepaid_biller_list_entity_response.dart';
import '../bill_payment_data_source.dart';

class BillPaymentRemoteDSImpl extends BillPaymentRemoteDS {
  final ApiService _apiService;

  BillPaymentRemoteDSImpl(
    this._apiService,
  );

  @override
  Future<HttpResponse<GetBillCategoriesEntity>> getBillCategories() {
    return _apiService.getBillCategories();
  }

  @override
  Future<HttpResponse<GetPostpaidBillerListEntityResponse>>
      getPostpaidBillerListResponse(
          {required GetPostpaidBillerListUseCaseParams params}) {
    return _apiService.getPostpaidBillerListData();
  }

  @override
  Future<HttpResponse<GetPostpaidBillerListEntityResponse>>
      getPostpaidBillerList(
          {required GetPostpaidBillerListUseCaseParams params}) {
    return _apiService.getPostpaidBillerListData();
  }

  @override
  Future<HttpResponse<GetPrepaidBillerListEntityResponse>>
      getPrepaidBillerListResponse(
          {required GetPrepaidBillerListUseCaseParams params}) {
    return _apiService.getPrepaidBillerListData();
  }

  @override
  Future<HttpResponse<GetPrepaidBillerListEntityResponse>> getPrepaidBillerList(
      {required GetPrepaidBillerListUseCaseParams params}) {
    return _apiService.getPrepaidBillerListData();
  }

  @override
  Future<HttpResponse<PayPrePaidResponse>> payPrepaidBillDs(
      {PayPrePaidUseCaseParams? params}) {
    return _apiService.payPrePaidBillData(PayPrePaidRequest(
        billerCode: params?.billerCode,
        billerName: params?.billerName,
        billingNumber: params?.billingNumber,
        serviceType: params?.serviceType,
        amount: params?.amount,
        currencyCode: params?.currencyCode,
        accountNo: params?.accountNo,
        isNewBiller: params?.isNewBiller,
        otpCode: params?.otpCode,
        CardId: params?.CardId,
        prepaidCategoryCode: params?.prepaidCategoryCode,
        prepaidCategoryType: params?.prepaidCategoryType,
        billingNumberRequired: params?.billingNumberRequired,
        isCreditCardPayment: params?.isCreditCardPayment));
  }

  @override
  Future<HttpResponse<PayPostPaidBillResponse>> payPostPaidBill(
      {required params}) {
    return _apiService.payPostPaidBill(PayPostPaidBillRequestEntity(
        accountNo: params.accountNo,
        billerList: params.billerList,
        currencyCode: params.currencyCode,
        isNewBiller: params.isNewBiller,
        otpCode: params.otpCode,
        CardId: params.CardId,
        isCreditCardPayment: params.isCreditCardPayment,
        totalAmount: params.totalAmount));
  }

  @override
  Future<HttpResponse<AddNewPostpaidBillerEntityResponse>>
      addNewPostpaidBillerResponse(
          {required AddNewPostpaidBillerUseCaseParams params}) {
    return _apiService.addNewPostpaidBillerData(
      AddNewPostpaidBillerEntityRequest(
          serviceType: params.serviceType,
          billerCode: params.billerCode,
          billingNumber: params.billingNumber,
          nickname: params.nickname),
    );
  }

  @override
  Future<HttpResponse<AddNewPostpaidBillerEntityResponse>> addNewPostpaidBiller(
      {required AddNewPostpaidBillerUseCaseParams params}) {
    return _apiService.addNewPostpaidBillerData(
      AddNewPostpaidBillerEntityRequest(
          serviceType: params.serviceType,
          billerCode: params.billerCode,
          billingNumber: params.billingNumber,
          nickname: params.nickname),
    );
  }

  @override
  Future<HttpResponse<ValidatePrePaidBillResponse>> validatePrePaidBill(
      {required ValidatePrePaidUseCaseParams params}) {
    return _apiService.validatePrePaidBill(ValidatePrePaidBillRequestEntity(
        billerCode: params.billerCode,
        amount: params.amount,
        serviceType: params.serviceType,
        billingNumber: params.billingNumber,
        prepaidCategoryCode: params.prepaidCategoryCode,
        prepaidCategoryType: params.prepaidCategoryType,
        billingNumberRequired: params.billingNumberRequired));
  }

  @override
  Future<HttpResponse<PostPaidBillInquiryResponse>> postPaidBillInquiry(
      {required params}) {
    return _apiService.postPaidBillInquiry(PostPaidBillInquiryRequestEntity(
      postpaidBillInquiries: params.postpaidBillInquiries,
/*        serviceType: params.serviceType,
        billerCode: params.billerCode,
        billingNumber: params.billingNumber*/
    ));
  }

  @override
  Future<HttpResponse<AddNewPrepaidBillerEntityResponse>> addNewPrepaidBiller(
      {required AddNewPrepaidBillerUseCaseParams params}) {
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
      ),
    );
  }

  @override
  Future<HttpResponse<GetBillerLookupListResponse>> getBillerLookuplist(
      {required GetBillerLookupUseCaseParams params}) {
    return _apiService.getBillerLookupList(
        GetBillerLookupListRequest(categoryName: params.categoryName));
  }

  @override
  Future<HttpResponse<GetPrePaidCategoriesResponse>> getPrePaidCategories(
      {required GetPrePaidCategoriesListUseCaseParams params}) {
    return _apiService.getPrePaidCategory(GetPrePaidCategoriesRequestEntity(
        billerCode: params.billerCode, serviceCode: params.serviceCode));
  }

  @override
  Future<HttpResponse<BaseResponse>> removeCustomerBilling({
    required RemoveCustomerBillingUseCaseParams params,
  }) {
    return _apiService.removeCustomerBilling(
      RemoveCustomerBillingRequest(
        billerCode: params.billerCode,
        billingNo: params.billingNo,
        serviceType: params.serviceType,
      ),
    );
  }

  @override
  Future<HttpResponse<BaseResponse>> removePrepaidBiller({
    required RemovePrepaidBillerUseCaseParams params,
  }) {
    return _apiService.removePrepaidBiller(
      RemovePrepaidBillerRequest(
        registrationID: params.registrationID,
      ),
    );
  }
}
