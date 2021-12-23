import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AddRequestMoneyContactUseCase extends BaseUseCase<NetworkError,
    AddRequestMoneyContactUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required AddRequestMoneyContactUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class AddRequestMoneyContactUseCaseParams extends Params {
  AddRequestMoneyContactUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
