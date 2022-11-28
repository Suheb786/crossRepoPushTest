import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestMoneyFailureUseCase extends BaseUseCase<NetworkError, RequestMoneyFailureUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required RequestMoneyFailureUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class RequestMoneyFailureUseCaseParams extends Params {
  RequestMoneyFailureUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
