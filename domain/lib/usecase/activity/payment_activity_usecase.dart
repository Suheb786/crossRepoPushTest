import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PaymentActivityUseCase
    extends BaseUseCase<NetworkError, PaymentActivityUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required PaymentActivityUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class PaymentActivityUseCaseParams extends Params {
  PaymentActivityUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
