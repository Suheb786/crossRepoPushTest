import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/country/fetch_allowed_issuers_usecase.dart';
import 'package:domain/usecase/register/student_job_income_usecase.dart';
import 'package:domain/usecase/upload_doc/send_documents_usecase.dart';
import 'package:domain/usecase/user/android_login_usecase.dart';
import 'package:domain/usecase/user/authenticate_bio_metric_usecase.dart';
import 'package:domain/usecase/user/change_my_number_usecase.dart';
import 'package:domain/usecase/user/check_bio_metric_support_use_case.dart';
import 'package:domain/usecase/user/check_customer_status_usecase.dart';
import 'package:domain/usecase/user/check_journey_status_usecase.dart';
import 'package:domain/usecase/user/check_user_name_mobile_usecase.dart';
import 'package:domain/usecase/user/check_username_usecase.dart';
import 'package:domain/usecase/user/check_version_update_usecase.dart';
import 'package:domain/usecase/user/confirm_application_data_get_usecase.dart';
import 'package:domain/usecase/user/confirm_detail_usecase.dart';
import 'package:domain/usecase/user/disable_finger_print_usecase.dart';
import 'package:domain/usecase/user/enable_biometric_usecase.dart';
import 'package:domain/usecase/user/enter_address_usecase.dart';
import 'package:domain/usecase/user/generate_key_pair_usecase.dart';
import 'package:domain/usecase/user/get_cipher_usecase.dart';
import 'package:domain/usecase/user/get_combo_values_usecase.dart';
import 'package:domain/usecase/user/get_current_user_usecase.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
import 'package:domain/usecase/user/home_address_dialog_usecase.dart';
import 'package:domain/usecase/user/id_verification_info_usecase.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:domain/usecase/user/logout_usecase.dart';
import 'package:domain/usecase/user/process_journey_via_mobile_usecase.dart';
import 'package:domain/usecase/user/product_selector_usecase.dart';
import 'package:domain/usecase/user/profile_details_usecase.dart';
import 'package:domain/usecase/user/register_prospect_usecase.dart';
import 'package:domain/usecase/user/save_user_data_usecase.dart';
import 'package:domain/usecase/user/scan_user_document_usecase.dart';
import 'package:domain/usecase/user/update_journey_usecase.dart';
import 'package:domain/usecase/user/upload_selfie_image_usecase.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[LoginUseCase] provider
final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
  (ref) => LoginUseCase(ref.read(userRepoProvider)),
);

///[ProfileDetailsUseCase] provider
final profileDetailsUseCaseProvider = Provider.autoDispose<ProfileDetailsUseCase>(
  (ref) => ProfileDetailsUseCase(ref.read(userRepoProvider)),
);

///[SendDocumentsUseCase] provider
final sendDocumentsUseCaseUseCaseProvider = Provider.autoDispose<SendDocumentsUseCase>(
  (ref) => SendDocumentsUseCase(ref.read(uploadDocumentRepositoryProvider)),
);

///[IdVerificationInfoUseCase] provider
final idVerificationInfoUseCaseProvider = Provider.autoDispose<IdVerificationInfoUseCase>(
  (ref) => IdVerificationInfoUseCase(),
);

///[FetchAllowedIssuersUseCase] provider
final fetchAllowedIssuersUseCaseProvider = Provider.autoDispose<FetchAllowedIssuersUseCase>(
  (ref) => FetchAllowedIssuersUseCase(ref.read(countryRepoProvider)),
);

///[ConfirmDetailUseCase] provider
final confirmDetailUseCaseProvider = Provider.autoDispose<ConfirmDetailUseCase>(
  (ref) => ConfirmDetailUseCase(ref.read(userRepoProvider)),
);

///[EnterAddressUseCase] provider
final enterAddressUseCaseProvider = Provider.autoDispose<EnterAddressUseCase>(
  (ref) => EnterAddressUseCase(ref.read(userRepoProvider)),
);

///[HomeAddressDialogUseCase] provider
final homeAddressDialogUseCaseProvider = Provider.autoDispose<HomeAddressDialogUseCase>(
  (ref) => HomeAddressDialogUseCase(
    ref.read(homeAddressDialogRepositoryProvider),
  ),
);

///[ProductSelectorUseCase] provider
final productSelectorUseCaseProvider = Provider.autoDispose<ProductSelectorUseCase>(
  (ref) => ProductSelectorUseCase(),
);

///[StudentJobIncomeUseCase] provider
final studentJobIncomeUseCaseProvider = Provider.autoDispose<StudentJobIncomeUseCase>(
  (ref) => StudentJobIncomeUseCase(ref.read(userRepoProvider)),
);

///[CheckUserNameUseCase] provider
final checkUserNameUseCaseProvider = Provider.autoDispose<CheckUserNameUseCase>(
  (ref) => CheckUserNameUseCase(ref.read(userRepoProvider)),
);

///[CheckUserNameMobileUseCase] provider
final checkUserNameMobileUseCaseProvider = Provider.autoDispose<CheckUserNameMobileUseCase>(
  (ref) => CheckUserNameMobileUseCase(ref.read(userRepoProvider)),
);

///[RegisterProspectUseCase] provider
final registerProspectUseCaseProvider = Provider.autoDispose<RegisterProspectUseCase>(
  (ref) => RegisterProspectUseCase(ref.read(userRepoProvider)),
);

///[VerifyOtpUseCase] provider
final verifyMobileOtpUseCaseProvider = Provider.autoDispose<VerifyOtpUseCase>(
  (ref) => VerifyOtpUseCase(ref.read(userRepoProvider)),
);

///[ScanUserDocumentUseCase] provider
final scanUserDocumentUseCaseProvider =
    Provider<ScanUserDocumentUseCase>((ref) => ScanUserDocumentUseCase(ref.read(userRepoProvider)));

///[GetTokenUseCase] provider
final getTokenUseCaseProvider =
    Provider<GetTokenUseCase>((ref) => GetTokenUseCase(ref.read(userRepoProvider)));

///[ConfirmApplicationDataGetUseCase] provider
final getConfirmApplicationDataUseCaseProvider = Provider<ConfirmApplicationDataGetUseCase>(
    (ref) => ConfirmApplicationDataGetUseCase(ref.read(userRepoProvider)));

///[LogoutUseCase] provider
final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) => LogoutUseCase(ref.read(userRepoProvider)));

///[DisableFingerPrintUseCase] provider
final disableFingerPrintUseCaseProvider =
    Provider<DisableFingerPrintUseCase>((ref) => DisableFingerPrintUseCase(ref.read(userRepoProvider)));

///[UploadSelfieImageUseCase] provider
final uploadSelfieImageUseCaseProvider =
    Provider<UploadSelfieImageUseCase>((ref) => UploadSelfieImageUseCase(ref.read(userRepoProvider)));

///[CheckBioMetricSupportUseCase] provider
final checkBioMetricSupportUseCaseProvider = Provider.autoDispose<CheckBioMetricSupportUseCase>(
  (ref) => CheckBioMetricSupportUseCase(
    ref.read(userRepoProvider),
  ),
);

///[AuthenticateBioMetricUseCase] provider
final authenticateBioMetricUseCaseProvider = Provider.autoDispose<AuthenticateBioMetricUseCase>(
  (ref) => AuthenticateBioMetricUseCase(
    ref.read(userRepoProvider),
  ),
);

///[GenerateKeyPairUseCase] provider
final generateKeyPairUseCaseProvider = Provider.autoDispose<GenerateKeyPairUseCase>(
  (ref) => GenerateKeyPairUseCase(
    ref.read(userRepoProvider),
  ),
);

///[EnableBiometricUseCase] provider
final enableBiometricUseCaseProvider = Provider.autoDispose<EnableBiometricUseCase>(
  (ref) => EnableBiometricUseCase(
    ref.read(userRepoProvider),
  ),
);

///[GetComboValuesUseCase] provider
final getComboValuesUseCaseProvider = Provider.autoDispose<GetComboValuesUseCase>(
  (ref) => GetComboValuesUseCase(
    ref.read(userRepoProvider),
  ),
);

/// get current logged in user use case provider
final currentUserUseCaseProvider =
    Provider<GetCurrentUserUseCase>((ref) => GetCurrentUserUseCase(ref.read(userRepoProvider)));

final customerStatusUseCaseProvider = Provider.autoDispose<CheckCustomerStatusUseCase>(
    (ref) => CheckCustomerStatusUseCase(ref.read(userRepoProvider)));

///get cipher usecase
final getCipherUseCaseProvider =
    Provider.autoDispose<GetCipherUseCase>((ref) => GetCipherUseCase(ref.read(userRepoProvider)));

///android login usecase
final androidLoginUseCaseProvider =
    Provider.autoDispose<AndroidLoginUseCase>((ref) => AndroidLoginUseCase(ref.read(userRepoProvider)));

///change my number usecase
final changeMyNumberUseCaseProvider =
    Provider.autoDispose<ChangeMyNumberUseCase>((ref) => ChangeMyNumberUseCase(ref.read(userRepoProvider)));

///change my number usecase
final checkVersionUpdateUseCaseProvider = Provider.autoDispose<CheckVersionUpdateUseCase>(
    (ref) => CheckVersionUpdateUseCase(ref.read(userRepoProvider)));

///save user usecase
final saveDataUserUseCaseProvider =
    Provider.autoDispose<SaveUserDataUseCase>((ref) => SaveUserDataUseCase(ref.read(userRepoProvider)));

final updateJourneyUseCaseProvider =
    Provider.autoDispose<UpdateJourneyUseCase>((ref) => UpdateJourneyUseCase(ref.read(userRepoProvider)));

final processJourneyViaMobileUseCaseProvider = Provider.autoDispose<ProcessJourneyViaMobileUseCase>(
    (ref) => ProcessJourneyViaMobileUseCase(ref.read(userRepoProvider)));

final checkJourneyStatusUseCaseProvider = Provider.autoDispose<CheckJourneyStatusUseCase>(
    (ref) => CheckJourneyStatusUseCase(ref.read(userRepoProvider)));
