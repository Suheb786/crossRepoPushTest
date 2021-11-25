import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class MyAccountUseCase
    extends BaseUseCase<NetworkError, MyAccountUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required MyAccountUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class MyAccountUseCaseParams extends Params {
  MyAccountUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
