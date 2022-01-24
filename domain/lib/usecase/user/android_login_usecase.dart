import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AndroidLoginUseCase
    extends BaseUseCase<NetworkError, AndroidLoginUseCaseParams, bool> {
  final UserRepository userRepository;

  AndroidLoginUseCase(this.userRepository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required AndroidLoginUseCaseParams params}) {
    return userRepository.androidLogin();
  }
}

class AndroidLoginUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
