import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckBioMetricSupportUseCase
    extends BaseUseCase<BaseError, CheckBioMetricSupportUseCaseParams, bool> {
  final UserRepository _userRepository;

  CheckBioMetricSupportUseCase(this._userRepository);

  @override
  Future<Either<BaseError, bool>> execute(
      {required CheckBioMetricSupportUseCaseParams params}) async {
    return _userRepository.checkBioMetricSupport();
  }
}

class CheckBioMetricSupportUseCaseParams extends Params {
  CheckBioMetricSupportUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
