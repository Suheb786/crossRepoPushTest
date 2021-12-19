import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PaymentActivityTransactionUseCase extends BaseUseCase<NetworkError,
    PaymentActivityTransactionUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required PaymentActivityTransactionUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class PaymentActivityTransactionUseCaseParams extends Params {
  PaymentActivityTransactionUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
