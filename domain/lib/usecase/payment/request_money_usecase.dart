import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestMoneyUseCase
    extends BaseUseCase<NetworkError, RequestMoneyUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required RequestMoneyUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class RequestMoneyUseCaseParams extends Params {
  RequestMoneyUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
