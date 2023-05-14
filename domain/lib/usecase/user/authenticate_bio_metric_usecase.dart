import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AuthenticateBioMetricUseCase extends BaseUseCase<BaseError, AuthenticateBioMetricUseCaseParams, bool> {
  final UserRepository _userRepository;

  AuthenticateBioMetricUseCase(this._userRepository);

  @override
  Future<Either<BaseError, bool>> execute({required AuthenticateBioMetricUseCaseParams params}) async {
    return _userRepository.authenticateBioMetric(
      params.title,
      params.localisedReason,
    );
  }
}

class AuthenticateBioMetricUseCaseParams extends Params {
  final String title;
  final String localisedReason;

  AuthenticateBioMetricUseCaseParams({this.title = "", this.localisedReason = ""});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
