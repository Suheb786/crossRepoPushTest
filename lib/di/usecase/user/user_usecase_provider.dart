import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/user/fetch_countries_usecase.dart';
import 'package:domain/usecase/user/register_number_usecase.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:domain/usecase/user/profile_details_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domain/usecase/user/upload_documents_usecase.dart';

final fetchCountriesUseCaseProvider =
    Provider.autoDispose<FetchCountriesUseCase>(
  (ref) => FetchCountriesUseCase(
    ref.read(countryRepoProvider),
  ),
);

final registerNumberUseCaseProvider =
    Provider.autoDispose<RegisterNumberUseCase>(
  (ref) => RegisterNumberUseCase(),
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