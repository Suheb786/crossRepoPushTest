import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/bill_payment/bill_payment_data_source.dart';
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
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
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

/// welcome repository management class
class BillPaymentRepositoryImpl extends BillPaymentRepository {
  final BillPaymentRemoteDS _remoteDS;

  BillPaymentRepositoryImpl(this._remoteDS);


  @override
  Future<Either<NetworkError, GetBillCategories>> getBillCategories() async {
    final result = await safeApiCall(_remoteDS.getBillCategories());
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetPostpaidBillerListModel>>
  getPostpaidBillerList(
      {required GetPostpaidBillerListUseCaseParams params}) async {
    final result = await safeApiCall(
      _remoteDS.getPostpaidBillerList(params: params),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetPrepaidBillerListModel>> getPrepaidBillerList(
      {required GetPrepaidBillerListUseCaseParams params}) async {
    final result = await safeApiCall(
      _remoteDS.getPrepaidBillerList(params: params),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, AddNewPostpaidBillerModel>> addNewPostpaidBiller(
      {required AddNewPostpaidBillerUseCaseParams params}) async {
    final result = await safeApiCall(
      _remoteDS.addNewPostpaidBiller(params: params),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, AddNewPrepaidBillerModel>> addNewPrepaidBiller(
      {required AddNewPrepaidBillerUseCaseParams params}) async {
    final result = await safeApiCall(
      _remoteDS.addNewPrepaidBiller(params: params),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetBillerLookUpList>> getBillerLookuplist(
      {required GetBillerLookupUseCaseParams params}) async {
    final result = await safeApiCall(
      _remoteDS.getBillerLookuplist(params: params),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, PayPrePaid>> payPrepaidBill(
      {PayPrePaidUseCaseParams? params}) async {
    final result = await safeApiCall(
      _remoteDS.payPrepaidBillDs(params: params!),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, PayPostPaidBill>> payPostPaidBill(
      {required params}) async {
    final result = await safeApiCall(
      _remoteDS.payPostPaidBill(params: params),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, PostPaidBillInquiry>> postPaidBillInquiry(
      {required params}) async {
    final result = await safeApiCall(
      _remoteDS.postPaidBillInquiry(params: params),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, ValidatePrePaidBill>> validatePrePaidBill(
      {required ValidatePrePaidUseCaseParams params}) async {
    final result = await safeApiCall(
      _remoteDS.validatePrePaidBill(params: params),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetPrePaidCategoriesModel>> getPrePaidCategories(
      {required GetPrePaidCategoriesListUseCaseParams params}) async {
    final result = await safeApiCall(
      _remoteDS.getPrePaidCategories(params: params),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> removeCustomerBilling({
    required RemoveCustomerBillingUseCaseParams params,
  }) async {
    final result = await safeApiCall(
      _remoteDS.removeCustomerBilling(params: params),
    );
    return result!.fold(
          (l) => Left(l),
          (r) {
        /*if (r.data.status!.isSuccess!) {
          AppConstants.SUCCESS_MESSAGE_BOOL =
              r.data.status!.statusMessage ?? "";
          return Right(r.isSuccessful());
        } else {
          AppConstants.ERROR_MESSAGE_BOOL = r.data.status!.statusMessage ?? "";
          return Right(false);
        }*/
            return Right(false);
      },
    );
  }

  @override
  Future<Either<NetworkError, bool>> removePrepaidBiller({required RemovePrepaidBillerUseCaseParams params,}) async{
    final result = await safeApiCall(
      _remoteDS.removePrepaidBiller(params: params),
    );
    return result!.fold(
          (l) => Left(l),
          (r) {
       /* if (r.data.status!.isSuccess!) {
          AppConstants.SUCCESS_MESSAGE_BOOL =
              r.data.status!.statusMessage ?? "";
          return Right(r.isSuccessful());
        } else {
          AppConstants.ERROR_MESSAGE_BOOL = r.data.status!.statusMessage ?? "";
          return Right(false);
        }*/
            return Right(false);
      },
    );
  }
}
