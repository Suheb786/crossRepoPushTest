import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class LogoutUseCase
    extends BaseUseCase<NetworkError, LogoutUseCaseParams, LogoutResponse> {
  final UserRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<NetworkError, LogoutResponse>> execute(
      {required LogoutUseCaseParams params}) {
    return _repository.logout();
  }
}

class LogoutUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
