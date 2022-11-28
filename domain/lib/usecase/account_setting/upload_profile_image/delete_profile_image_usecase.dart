import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DeleteProfileImageUseCase extends BaseUseCase<NetworkError, DeleteProfileImageUseCaseParams, bool> {
  final AccountSettingsRepository _accountSettingsRepository;

  DeleteProfileImageUseCase(this._accountSettingsRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required DeleteProfileImageUseCaseParams params}) {
    return _accountSettingsRepository.deleteProfileImage();
  }
}

class DeleteProfileImageUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
