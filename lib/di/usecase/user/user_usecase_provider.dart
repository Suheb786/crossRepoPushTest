import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/user/account_ready_usecase.dart';
import 'package:domain/usecase/user/confirm_detail_usecase.dart';
import 'package:domain/usecase/user/create_password_usecase.dart';
import 'package:domain/usecase/user/enter_address_usecase.dart';
import 'package:domain/usecase/user/fetch_countries_usecase.dart';
import 'package:domain/usecase/user/id_verification_info_usecase.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:domain/usecase/user/profile_details_usecase.dart';
import 'package:domain/usecase/user/register_number_usecase.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domain/usecase/user/send_documents_usecase.dart';

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
final profileDetailsUseCaseProvider =
    Provider.autoDispose<ProfileDetailsUseCase>(
  (ref) => ProfileDetailsUseCase(),
);

///[UploadDocumentsUseCase] provider
final sendDocumentsUseCaseUseCaseProvider =
    Provider.autoDispose<SendDocumentsUseCase>(
  (ref) => SendDocumentsUseCase(),
);

///[CreatePasswordUseCase] provider
final createPasswordUseCaseProvider =
    Provider.autoDispose<CreatePasswordUseCase>(
  (ref) => CreatePasswordUseCase(),
);

///[IdVerificationInfoUseCase] provider
final idVerificationInfoUseCaseProvider =
    Provider.autoDispose<IdVerificationInfoUseCase>(
  (ref) => IdVerificationInfoUseCase(),
);

///[ConfirmDetailUseCase] provider
final confirmDetailUseCaseProvider = Provider.autoDispose<ConfirmDetailUseCase>(
  (ref) => ConfirmDetailUseCase(),
);

///[EnterAddressUseCase] provider
final enterAddressUseCaseProvider = Provider.autoDispose<EnterAddressUseCase>(
  (ref) => EnterAddressUseCase(),
);

///[EnterAddressUseCase] provider
final accountReadyUseCaseProvider = Provider.autoDispose<AccountReadyUseCase>(
  (ref) => AccountReadyUseCase(),
);
