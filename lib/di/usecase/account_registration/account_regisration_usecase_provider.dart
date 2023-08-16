import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/country/fetch_countries_usecase.dart';
import 'package:domain/usecase/country/fetch_country_by_code_usecase.dart';
import 'package:domain/usecase/user/create_password_usecase.dart';
import 'package:domain/usecase/user/register_number_usecase.dart';
import 'package:domain/usecase/user/resend_email_otp_usecase.dart';
import 'package:domain/usecase/user/verify_email_otp_usecase.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[FetchCountriesUseCase] provider
final fetchCountriesUseCaseProvider = Provider.autoDispose<FetchCountriesUseCase>(
  (ref) => FetchCountriesUseCase(ref.read(countryRepoProvider)),
);

///[FetchCountryByCodeUseCase] provider
final fetchCountryByCodeUseCaseProvider = Provider.autoDispose<FetchCountryByCodeUseCase>(
  (ref) => FetchCountryByCodeUseCase(
    ref.read(countryRepoProvider),
  ),
);

///[RegisterNumberUseCase] provider
final registerNumberUseCaseProvider = Provider.autoDispose<RegisterNumberUseCase>(
  (ref) => RegisterNumberUseCase(),
);

///[VerifyOtpUseCase] provider
final verifyOtpUseCaseProvider = Provider.autoDispose<VerifyOtpUseCase>(
  (ref) => VerifyOtpUseCase(ref.read(userRepoProvider)),
);

final verifyEmailOtpUseCaseProvider = Provider.autoDispose<VerifyEmailOtpUseCase>(
  (ref) => VerifyEmailOtpUseCase(ref.read(userRepoProvider)),
);

///[CreatePasswordUseCase] provider
final createPasswordUseCaseProvider = Provider.autoDispose<CreatePasswordUseCase>(
  (ref) => CreatePasswordUseCase(ref.read(userRepoProvider)),
);

///resend email otp
final resendEmailOTPUseCaseProvider = Provider.autoDispose<ResendEmailOTPUseCase>(
  (ref) => ResendEmailOTPUseCase(ref.read(userRepoProvider)),
);
