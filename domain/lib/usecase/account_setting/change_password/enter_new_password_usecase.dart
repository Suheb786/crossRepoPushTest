import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class EnterNewPasswordUseCase extends BaseUseCase<NetworkError,
    EnterNewPasswordUseCaseParams, ProfileChangedSuccessResponse> {
  final AccountSettingsRepository _accountSettingsRepository;

  EnterNewPasswordUseCase(this._accountSettingsRepository);

  @override
  Future<Either<NetworkError, ProfileChangedSuccessResponse>> execute(
      {required EnterNewPasswordUseCaseParams params}) {
    return _accountSettingsRepository.changePassword(
        oldPassword: params.currentPassword,
        newPassword: params.newPassword,
        confirmNewPassword: params.newPassword);
  }
}

class EnterNewPasswordUseCaseParams extends Params {
  final String currentPassword;
  final String newPassword;

  EnterNewPasswordUseCaseParams(
      {required this.currentPassword, required this.newPassword});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(currentPassword)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_PASSWORD,
          cause: Exception()));
    } else if (Validator.isEmpty(newPassword)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_NEW_PASSWORD,
          cause: Exception()));
    }
    return Right(true);
  }
}
