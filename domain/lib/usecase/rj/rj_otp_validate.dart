import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/rj/rj_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RJOtpValidateUseCase extends BaseUseCase<NetworkError, RJOtpValidateUseCaseParams, bool> {
  final RJRepository _repository;

  RJOtpValidateUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required RJOtpValidateUseCaseParams params}) {
    return _repository.rjOtpValidate();
  }
}

class RJOtpValidateUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
