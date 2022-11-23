import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreditCardVerificationSuccessUseCase
    extends BaseUseCase<NetworkError, CreditCardVerificationSuccessUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required CreditCardVerificationSuccessUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class CreditCardVerificationSuccessUseCaseParams extends Params {
  CreditCardVerificationSuccessUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
