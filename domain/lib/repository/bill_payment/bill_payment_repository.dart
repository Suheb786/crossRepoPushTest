import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model.dart';
import 'package:domain/usecase/bill_payments/post_paid_bills/get_postpaid_biller_list_usecase.dart';

abstract class BillPaymentRepository {
  ///get bill categories
  Future<Either<NetworkError, GetPostpaidBillerListModel>>
      getPostpaidBillerList(
          {required GetPostpaidBillerListUseCaseParams params});
}
