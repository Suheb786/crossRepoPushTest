import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/check_username.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckUserNameUseCase extends BaseUseCase<NetworkError, CheckUserNameUseCaseParams, CheckUsername> {
  final UserRepository _repository;

  CheckUserNameUseCase(this._repository);

  @override
  Future<Either<NetworkError, CheckUsername>> execute({required CheckUserNameUseCaseParams params}) {
    return _repository.checkUserName(email: params.email);
  }
}

class CheckUserNameUseCaseParams extends Params {
  final String email;

  CheckUserNameUseCaseParams({required this.email});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
