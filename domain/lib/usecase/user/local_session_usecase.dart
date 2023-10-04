import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class LocalSessionUseCase extends BaseUseCase<BaseError, LocalSessionUseCaseParams, bool> {
  final UserRepository userRepository;

  LocalSessionUseCase(this.userRepository);

  @override
  Future<Either<BaseError, bool>> execute({required LocalSessionUseCaseParams params}) async {
    switch (params.localSessionEnum) {
      case LocalSessionEnum.startSession:
        return userRepository.startLocalSession();
      case LocalSessionEnum.endSession:
        return userRepository.endLocalSession();
      case LocalSessionEnum.getSessionTimeoutWarning:
        return userRepository.getLocalSessionWarning(params.onSessionEndWarning!, params.onSessionTimeOut!);
    }
  }
}

class LocalSessionUseCaseParams extends Params {
  LocalSessionEnum localSessionEnum;
  Function()? onSessionEndWarning;
  Function()? onSessionTimeOut;

  LocalSessionUseCaseParams(
      {required this.localSessionEnum, this.onSessionEndWarning, this.onSessionTimeOut});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

enum LocalSessionEnum {
  startSession,
  endSession,
  getSessionTimeoutWarning,
}
