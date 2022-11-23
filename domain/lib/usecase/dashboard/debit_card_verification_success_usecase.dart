import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DebitCardVerificationSuccessUseCase
    extends BaseUseCase<NetworkError, DebitCardVerificationSuccessUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required DebitCardVerificationSuccessUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class DebitCardVerificationSuccessUseCaseParams extends Params {
  DebitCardVerificationSuccessUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
