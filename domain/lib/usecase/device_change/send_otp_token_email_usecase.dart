import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/change_device/change_device_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SendOtpTokenEmailOtpUseCase extends BaseUseCase<NetworkError, SendOtpTokenEmailOtpUseCaseParams, bool> {
  final ChangeDeviceRepository _repository;

  SendOtpTokenEmailOtpUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required SendOtpTokenEmailOtpUseCaseParams params}) {
    return _repository.sendOtpTokenEmail();
  }
}

class SendOtpTokenEmailOtpUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
