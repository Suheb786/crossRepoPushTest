import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UploadProfileImageUseCase extends BaseUseCase<NetworkError, UploadProfileImageUseCaseParams, bool> {
  final AccountSettingsRepository _accountSettingsRepository;

  UploadProfileImageUseCase(this._accountSettingsRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required UploadProfileImageUseCaseParams params}) {
    return _accountSettingsRepository.updateProfileImage(filePath: params.imagePath);
  }
}

class UploadProfileImageUseCaseParams extends Params {
  final String imagePath;

  UploadProfileImageUseCaseParams({required this.imagePath});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
