import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ValidateOtpForNewEmailAddressUseCase extends BaseUseCase<BaseError,
    ValidateOtpForNewEmailAddressUseCaseParams, ProfileChangedSuccessResponse> {
  final AccountSettingsRepository _accountSettingsRepository;
  final UserRepository _userRepository;

  ValidateOtpForNewEmailAddressUseCase(this._accountSettingsRepository, this._userRepository);

  @override
  Future<Either<BaseError, ProfileChangedSuccessResponse>> execute(
      {required ValidateOtpForNewEmailAddressUseCaseParams params}) async {
    return Future.value(
      (await _accountSettingsRepository.verifyChangeEmail(otp: params.otp)).fold((l) => Left(l),
          (response) async {
        return (await _userRepository.getCurrentUser()).fold((l) => Left(l), (currentUser) async {
          print('current user email--->${currentUser.email}');
          currentUser.email = params.email;
          return (await _userRepository.saveUser(currentUser)).fold((l) => Left(l), (user) async {
            print('savedUser--->${user.email}');
            return Right(response);
          });
        });
      }),
    );
  }
}

class ValidateOtpForNewEmailAddressUseCaseParams extends Params {
  final String otp;
  final String email;

  ValidateOtpForNewEmailAddressUseCaseParams({required this.otp, required this.email});

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_OTP, cause: Exception()));
    }
    return Right(true);
  }
}
