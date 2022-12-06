import 'package:data/entity/remote/base/base_response.dart';
import 'package:data/entity/remote/bill_payment/get_bill_categories/get_bill_categories_entity.dart';
import 'package:data/entity/remote/bill_payment/get_postpaid_biller_list/get_postpaid_biller_list_entity_response.dart';
import 'package:data/entity/remote/bill_payment/get_pre_paid_categories/get_pre_paid_categories_response.dart';
import 'package:data/entity/remote/bill_payment/pay_post_paid_bill/pay_post_paid_bill_response.dart';
import 'package:data/entity/remote/bill_payment/pay_prepaid_bill/pay_prepaid_bill_response.dart';
import 'package:data/entity/remote/bill_payment/post_paid_bill_inquiry/post_paid_bill_inquiry_response.dart';
import 'package:data/entity/remote/bill_payment/validate_prepaid_biller/validate_pre_paid_bill_response.dart';
import 'package:domain/usecase/bill_payment/add_new_postpaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/add_new_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/get_biller_lookup_list_usecase.dart';
import 'package:domain/usecase/bill_payment/get_postpaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_post_paid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_prepaid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/post_paid_bill_inquiry_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_customer_billing_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/validate_prepaid_bill_usecase.dart';
import 'package:retrofit/dio.dart';

import '../../entity/remote/bill_payment/add_new_postpaid_biller/add_new_postpaid_biller_entity_response.dart';
import '../../entity/remote/bill_payment/add_new_prepaid_biller/add_new_prepaid_biller_entity_response.dart';
import '../../entity/remote/bill_payment/get_biller_lookup_List/get_biller_lookup_list_response.dart';
import '../../entity/remote/bill_payment/get_prepaid_biller_list/get_prepaid_biller_list_entity_response.dart';

abstract class BillPaymentRemoteDS {

  ///get bill categories
  Future<HttpResponse<GetBillCategoriesEntity>> getBillCategories();

  Future<HttpResponse<GetPrepaidBillerListEntityResponse>> getPrepaidBillerList(
      {required GetPrepaidBillerListUseCaseParams params});

  Future<HttpResponse<GetPostpaidBillerListEntityResponse>>
      getPostpaidBillerList(
          {required GetPostpaidBillerListUseCaseParams params});

  Future<HttpResponse<PayPrePaidResponse>> payPrepaidBillDs(
      {required PayPrePaidUseCaseParams params});

  Future<HttpResponse<PayPostPaidBillResponse>> payPostPaidBill(
      {required PayPostPaidBillUseCaseParams params});

  Future<HttpResponse<ValidatePrePaidBillResponse>> validatePrePaidBill(
      {required ValidatePrePaidUseCaseParams params});

  Future<HttpResponse<PostPaidBillInquiryResponse>> postPaidBillInquiry(
      {required PostPaidBillInquiryUseCaseParams params});

  Future<HttpResponse<BaseResponse>> addNewPostpaidBiller(
      {required AddNewPostpaidBillerUseCaseParams params});

  Future<HttpResponse<BaseResponse>> addNewPrepaidBiller(
      {required AddNewPrepaidBillerUseCaseParams params});

  Future<HttpResponse<GetBillerLookupListResponse>> getBillerLookuplist(
      {required GetBillerLookupUseCaseParams params});

  Future<HttpResponse<GetPrePaidCategoriesResponse>> getPrePaidCategories(
      {required GetPrePaidCategoriesListUseCaseParams params});

  Future<HttpResponse<BaseResponse>> removeCustomerBilling({
    required RemoveCustomerBillingUseCaseParams params,
  });

  Future<HttpResponse<BaseResponse>> removePrepaidBiller({
    required RemovePrepaidBillerUseCaseParams params,
  });
}
