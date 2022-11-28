import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SendAmountToContactSuccessUseCase
    extends BaseUseCase<NetworkError, SendAmountToContactSuccessUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required SendAmountToContactSuccessUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class SendAmountToContactSuccessUseCaseParams extends Params {
  SendAmountToContactSuccessUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
