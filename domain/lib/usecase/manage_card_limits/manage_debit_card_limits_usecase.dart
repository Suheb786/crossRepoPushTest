import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ManageDebitCardLimitUseCase
    extends BaseUseCase<NetworkError, ManageDebitCardLimitUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required ManageDebitCardLimitUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class ManageDebitCardLimitUseCaseParams extends Params {
  ManageDebitCardLimitUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
