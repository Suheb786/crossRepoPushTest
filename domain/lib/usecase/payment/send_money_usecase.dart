import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SendMoneyUseCase extends BaseUseCase<NetworkError, SendMoneyUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required SendMoneyUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class SendMoneyUseCaseParams extends Params {
  SendMoneyUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
