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

class ValidateOtpForNewMobileNumberUseCase extends BaseUseCase<BaseError,
    ValidateOtpForNewMobileNumberUseCaseParams, ProfileChangedSuccessResponse> {
  final AccountSettingsRepository _accountSettingsRepository;
  final UserRepository _userRepository;

  ValidateOtpForNewMobileNumberUseCase(
      this._accountSettingsRepository, this._userRepository);

  @override
  Future<Either<BaseError, ProfileChangedSuccessResponse>> execute(
      {required ValidateOtpForNewMobileNumberUseCaseParams params}) async {
    return Future.value(
      (await _accountSettingsRepository.verifyChangeMobile(
              otp: params.otp,
              mobileCode: params.mobileCode,
              mobileNo: params.mobileNo))
          .fold((l) => Left(l), (response) async {
        return (await _userRepository.getCurrentUser()).fold((l) => Left(l),
            (currentUser) async {
          print('mobileno from ui:---${params.mobileNo}');
          currentUser.mobile = params.mobileNo;
          currentUser.mobileCode = params.mobileCode;
          return (await _userRepository.saveUser(currentUser))
              .fold((l) => Left(l), (user) async {
            print('savedUser--->${user.mobile}');
            return Right(response);
          });
        });
      }),
    );
  }
}

class ValidateOtpForNewMobileNumberUseCaseParams extends Params {
  final String otp;
  final String mobileNo;
  final String mobileCode;

  ValidateOtpForNewMobileNumberUseCaseParams(
      {required this.otp, required this.mobileNo, required this.mobileCode});

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
