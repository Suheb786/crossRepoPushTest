import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transactions.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class BillPaymentsTransactionUseCase
    extends BaseUseCase<NetworkError, BillPaymentsTransactionUseCaseParams, BillPaymentsTransactionModel> {
  final BillPaymentRepository billPaymentRepository;

  BillPaymentsTransactionUseCase(this.billPaymentRepository);

  @override
  Future<Either<NetworkError, BillPaymentsTransactionModel>> execute({
    required BillPaymentsTransactionUseCaseParams params,
  }) {
    return billPaymentRepository.billPaymentsTransactionHistory(params: params);
  }
}

class BillPaymentsTransactionUseCaseParams extends Params {
  final num? pageSize;
  final num? pageNo;

  BillPaymentsTransactionUseCaseParams({this.pageSize, this.pageNo});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
