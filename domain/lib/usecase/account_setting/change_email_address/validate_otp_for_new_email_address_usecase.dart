import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ValidateOtpForNewEmailAddressUseCase extends BaseUseCase<NetworkError,
    ValidateOtpForNewEmailAddressUseCaseParams, ProfileChangedSuccessResponse> {
  final AccountSettingsRepository _accountSettingsRepository;

  ValidateOtpForNewEmailAddressUseCase(this._accountSettingsRepository);

  @override
  Future<Either<NetworkError, ProfileChangedSuccessResponse>> execute(
      {required ValidateOtpForNewEmailAddressUseCaseParams params}) {
    return _accountSettingsRepository.verifyChangeEmail(otp: params.otp);
  }
}

class ValidateOtpForNewEmailAddressUseCaseParams extends Params {
  final String otp;

  ValidateOtpForNewEmailAddressUseCaseParams({required this.otp});

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_OTP,
          cause: Exception()));
    }
    return Right(true);
  }
}
