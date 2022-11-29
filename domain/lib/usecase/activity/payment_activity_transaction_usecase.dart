import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PaymentActivityTransactionUseCase
    extends BaseUseCase<NetworkError, PaymentActivityTransactionUseCaseParams, PaymentActivityResponse> {
  final PaymentRepository _repository;

  PaymentActivityTransactionUseCase(this._repository);

  @override
  Future<Either<NetworkError, PaymentActivityResponse>> execute(
      {required PaymentActivityTransactionUseCaseParams params}) {
    return _repository.getPaymentActivity(filterDays: params.filterDays);
  }
}

class PaymentActivityTransactionUseCaseParams extends Params {
  final int? filterDays;

  PaymentActivityTransactionUseCaseParams({this.filterDays});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
