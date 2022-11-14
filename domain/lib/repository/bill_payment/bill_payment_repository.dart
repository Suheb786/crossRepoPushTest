import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_postpaid_biller_model.dart';
import 'package:domain/model/bill_payments/add_new_prepaid_biller/add_new_prepaid_biller_model.dart';
import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/get_biller_lookup_list.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:domain/usecase/bill_payment/add_new_postpaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/add_new_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/get_postpaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_post_paid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_prepaid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/post_paid_bill_inquiry_usecase.dart';
import 'package:domain/usecase/bill_payment/get_biller_lookup_list_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_customer_billing_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/validate_prepaid_bill_usecase.dart';


abstract class BillPaymentRepository {

  ///get bill categories
  Future<Either<NetworkError, GetBillCategories>> getBillCategories();


  ///get bill categories
  Future<Either<NetworkError, GetPostpaidBillerListModel>>
  getPostpaidBillerList(
      {required GetPostpaidBillerListUseCaseParams params});

  Future<Either<NetworkError, GetPrepaidBillerListModel>> getPrepaidBillerList(
      {required GetPrepaidBillerListUseCaseParams params});

  ///pay pre paid bill
  Future<Either<NetworkError, PayPrePaid>> payPrepaidBill(
      {PayPrePaidUseCaseParams params});

  Future<Either<NetworkError, PayPostPaidBill>> payPostPaidBill(
      {required PayPostPaidBillUseCaseParams params});

  Future<Either<NetworkError, ValidatePrePaidBill>> validatePrePaidBill(
      {required ValidatePrePaidUseCaseParams params});

  Future<Either<NetworkError, PostPaidBillInquiry>> postPaidBillInquiry(
      {required PostPaidBillInquiryUseCaseParams params});

  Future<Either<NetworkError, AddNewPostpaidBillerModel>> addNewPostpaidBiller(
      {required AddNewPostpaidBillerUseCaseParams params});

  Future<Either<NetworkError, AddNewPrepaidBillerModel>> addNewPrepaidBiller(
      {required AddNewPrepaidBillerUseCaseParams params});

  Future<Either<NetworkError, GetBillerLookUpList>> getBillerLookuplist({
    required GetBillerLookupUseCaseParams params,
  });

  Future<Either<NetworkError, GetPrePaidCategoriesModel>> getPrePaidCategories({
    required GetPrePaidCategoriesListUseCaseParams params,
  });

  Future<Either<NetworkError, bool>> removeCustomerBilling({
    required RemoveCustomerBillingUseCaseParams params,
  });

  Future<Either<NetworkError, bool>> removePrepaidBiller({
    required RemovePrepaidBillerUseCaseParams params,
  });
}
