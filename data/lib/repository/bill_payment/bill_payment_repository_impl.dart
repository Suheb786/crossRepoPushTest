import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/bill_payment/bill_payment_data_source.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/bill_payments/post_paid_bills/get_postpaid_biller_list_usecase.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model.dart';

class BillPaymentRepositoryImpl extends BillPaymentRepository {
  final BillPaymentRemoteDS _remoteDS;

  BillPaymentRepositoryImpl(this._remoteDS);

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
}
