import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/utility/utility_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckDeviceCompatibilityUsecase
    extends BaseUseCase<BaseError, CheckDeviceCompatibilityUsecaseParams, bool> {
  final UtilityRepository _repository;

  CheckDeviceCompatibilityUsecase(this._repository);

  @override
  Future<Either<BaseError, bool>> execute({required CheckDeviceCompatibilityUsecaseParams params}) async {
    return _repository.checkDeviceCompatibility();
  }
}

class CheckDeviceCompatibilityUsecaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
