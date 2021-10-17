import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AccountReadyUseCase
    extends BaseUseCase<LocalError, AccountReadyUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required AccountReadyUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class AccountReadyUseCaseParams extends Params {
  AccountReadyUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
