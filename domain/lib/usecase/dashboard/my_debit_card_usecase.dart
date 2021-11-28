import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class MyDebitCardUseCase
    extends BaseUseCase<NetworkError, MyDebitCardUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required MyDebitCardUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class MyDebitCardUseCaseParams extends Params {
  MyDebitCardUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
