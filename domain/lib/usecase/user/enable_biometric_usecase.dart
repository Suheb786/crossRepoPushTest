import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EnableBiometricUseCase
    extends BaseUseCase<NetworkError, EnableBiometricUseCaseParams, bool> {
  final UserRepository _repository;

  EnableBiometricUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required EnableBiometricUseCaseParams params}) {
    return _repository.enableBiometric();
  }
}

class EnableBiometricUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
