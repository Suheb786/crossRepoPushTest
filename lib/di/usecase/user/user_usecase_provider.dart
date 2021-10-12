import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/user/fetch_countries_usecase.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:domain/usecase/user/register_number_usecase.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[FetchCountriesUseCase] provider
final fetchCountriesUseCaseProvider =
    Provider.autoDispose<FetchCountriesUseCase>(
  (ref) => FetchCountriesUseCase(
    ref.read(countryRepoProvider),
  ),
);

///[RegisterNumberUseCase] provider
final registerNumberUseCaseProvider =
    Provider.autoDispose<RegisterNumberUseCase>(
  (ref) => RegisterNumberUseCase(),
);

///[LoginUseCase] provider
final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
  (ref) => LoginUseCase(),
);

///[VerifyOtpUseCase] provider
final verifyOtpUseCaseProvider = Provider.autoDispose<VerifyOtpUseCase>(
  (ref) => VerifyOtpUseCase(),
);
