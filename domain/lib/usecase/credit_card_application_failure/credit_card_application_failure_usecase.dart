import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreditCardApplicationFailureUseCase extends BaseUseCase<NetworkError,
    CreditCardApplicationFailureUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required CreditCardApplicationFailureUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class CreditCardApplicationFailureUseCaseParams extends Params {
  CreditCardApplicationFailureUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
