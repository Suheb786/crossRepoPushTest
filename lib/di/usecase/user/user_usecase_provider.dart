import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/user/fetch_countries_usecase.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:domain/usecase/user/register_number_usecase.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:domain/usecase/user/profile_details_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domain/usecase/user/upload_documents_usecase.dart';
import 'package:domain/usecase/register/review_app_usecase.dart';

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

///[ProfileDetailsUseCase] provider
final profileDetailsUseCaseProvider = Provider.autoDispose<ProfileDetailsUseCase>(
      (ref) => ProfileDetailsUseCase(),
);

///[UploadDocumentsUseCase] provider
final uploadDocumentsUseCaseProvider = Provider.autoDispose<UploadDocumentsUseCase>(
      (ref) => UploadDocumentsUseCase(),
);

///[ReviewApplicationUseCase] provider
final reviewApplicationUseCaseProvider = Provider.autoDispose<ReviewApplicationUseCase>(
      (ref) => ReviewApplicationUseCase(),
);