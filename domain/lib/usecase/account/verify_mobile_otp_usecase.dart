import 'package:dartz/dartz.dart';

import '../../error/app_error.dart';
import '../../error/network_error.dart';
import '../../repository/account/account_repository.dart';
import '../base/base_usecase.dart';
import '../base/params.dart';

class OnboardingVerifyMobileOtpUsecase
    extends BaseUseCase<NetworkError, OnboardingVerifyMobileOtpUsecaseParams, bool> {
  final AccountRepository _accountRepository;

  OnboardingVerifyMobileOtpUsecase(this._accountRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required OnboardingVerifyMobileOtpUsecaseParams params}) {
    return _accountRepository.verifyMobileOTP(params: params);
  }
}

class OnboardingVerifyMobileOtpUsecaseParams extends Params {
  final String? MobileNo;
  final String? OTPCode;
  final bool? GetToken;

  OnboardingVerifyMobileOtpUsecaseParams({this.MobileNo, this.OTPCode, this.GetToken = true});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
