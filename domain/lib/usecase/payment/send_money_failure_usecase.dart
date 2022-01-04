import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SendMoneyFailureUseCase
    extends BaseUseCase<NetworkError, SendMoneyFailureUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required SendMoneyFailureUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class SendMoneyFailureUseCaseParams extends Params {
  SendMoneyFailureUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
