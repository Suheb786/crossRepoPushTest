import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class EnterNewPasswordUseCase extends BaseUseCase<NetworkError, EnterNewPasswordUseCaseParams, bool> {
  final AccountSettingsRepository _accountSettingsRepository;

  EnterNewPasswordUseCase(this._accountSettingsRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required EnterNewPasswordUseCaseParams params}) {
    return _accountSettingsRepository.changePassword(
        oldPassword: params.currentPassword,
        newPassword: params.newPassword,
        confirmNewPassword: params.confirmNewPassword);
  }
}

class EnterNewPasswordUseCaseParams extends Params {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  final bool minimumEightCharacters;
  final bool hasUpperCase;
  final bool hasSymbol;
  final bool containsDigit;
  final bool isCurrentPasswordValid;

  EnterNewPasswordUseCaseParams(
      {required this.currentPassword,
      required this.newPassword,
      required this.confirmNewPassword,
      required this.containsDigit,
      required this.hasSymbol,
      required this.hasUpperCase,
      required this.minimumEightCharacters,
      required this.isCurrentPasswordValid});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(currentPassword)) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_PASSWORD, cause: Exception()));
    } else if (!isCurrentPasswordValid) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.CURRENT_PASSWORD_INVALID, cause: Exception()));
    } else if (Validator.isEmpty(newPassword)) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_NEW_PASSWORD, cause: Exception()));
    } else if (!minimumEightCharacters || !hasUpperCase || !hasSymbol || !containsDigit) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.PASSWORD_NOT_MEET_CRITERIA, cause: Exception()));
    } else if (confirmNewPassword != newPassword) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.CONFIRM_PASSWORD_NOT_MATCH_WITH_NEW_PASSWORD,
          cause: Exception()));
    }
    return Right(true);
  }
}
