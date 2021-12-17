import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AccountTransactionUseCase
    extends BaseUseCase<NetworkError, AccountTransactionUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required AccountTransactionUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class AccountTransactionUseCaseParams extends Params {
  AccountTransactionUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
