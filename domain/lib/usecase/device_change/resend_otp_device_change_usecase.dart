import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/change_device/change_device_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ResendOtpDeviceChangeUseCase extends BaseUseCase<NetworkError,
    ResendOtpDeviceChangeUseCaseParams, bool> {
  final ChangeDeviceRepository _repository;

  ResendOtpDeviceChangeUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required ResendOtpDeviceChangeUseCaseParams params}) {
    return _repository.resendOtpDeviceChange();
  }
}

class ResendOtpDeviceChangeUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
