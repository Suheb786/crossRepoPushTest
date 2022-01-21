import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class IphoneLoginUseCase
    extends BaseUseCase<NetworkError, IphoneLoginUseCaseParams, bool> {
  final UserRepository userRepository;

  IphoneLoginUseCase(this.userRepository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required IphoneLoginUseCaseParams params}) {
    return userRepository.iphoneLogin();
  }
}

class IphoneLoginUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
