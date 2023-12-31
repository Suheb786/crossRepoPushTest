import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetTokenUseCase extends BaseUseCase<NetworkError, GetTokenUseCaseParams, bool> {
  final UserRepository _repository;

  GetTokenUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required GetTokenUseCaseParams params}) {
    return _repository.getToken();
  }
}

class GetTokenUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
