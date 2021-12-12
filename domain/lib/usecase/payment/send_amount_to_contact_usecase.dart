import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SendAmountToContactUseCase
    extends BaseUseCase<NetworkError, SendAmountToContactUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required SendAmountToContactUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class SendAmountToContactUseCaseParams extends Params {
  SendAmountToContactUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
