import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckVersionUpdateUseCase
    extends BaseUseCase<NetworkError, CheckVersionUpdateUseCaseParams, bool> {
  final UserRepository userRepository;

  CheckVersionUpdateUseCase(this.userRepository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {CheckVersionUpdateUseCaseParams? params}) async {
    return userRepository.checkVersionUpdate();
  }
}

class CheckVersionUpdateUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
