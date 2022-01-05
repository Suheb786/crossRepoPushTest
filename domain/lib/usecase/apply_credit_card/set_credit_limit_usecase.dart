import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SetCreditLimitUseCase
    extends BaseUseCase<NetworkError, SetCreditLimitUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required SetCreditLimitUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class SetCreditLimitUseCaseParams extends Params {
  SetCreditLimitUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
