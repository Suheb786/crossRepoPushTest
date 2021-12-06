import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DisableFingerPrintUseCase
    extends BaseUseCase<NetworkError, DisableFingerPrintUseCaseParams, bool> {
  final UserRepository _repository;

  DisableFingerPrintUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required DisableFingerPrintUseCaseParams params}) {
    return _repository.disableFingerPrint();
  }
}

class DisableFingerPrintUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
