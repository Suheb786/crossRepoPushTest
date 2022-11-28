import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AddSendMoneyContactUseCase extends BaseUseCase<NetworkError, AddSendMoneyContactUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required AddSendMoneyContactUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class AddSendMoneyContactUseCaseParams extends Params {
  AddSendMoneyContactUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
