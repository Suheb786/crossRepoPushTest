import 'package:data/di/local_module.dart';
import 'package:data/di/network_module.dart';
import 'package:data/repository/account/account_repository_impl.dart';
import 'package:data/repository/account_settings/account_settings_impl.dart';
import 'package:data/repository/activity/activity_repository_impl.dart';
import 'package:data/repository/app_flyer_repo/app_flyer_repository_impl.dart';
import 'package:data/repository/bank_smart/bank_smart_repository_impl.dart';
import 'package:data/repository/card/card_repository_impl.dart';
import 'package:data/repository/card_processing/card_processing_repository_impl.dart';
import 'package:data/repository/country/country_repository_impl.dart';
import 'package:data/repository/dashboard/dashboard_repository_impl.dart';
import 'package:data/repository/device_change/device_change_repository_impl.dart';
import 'package:data/repository/dynamic_link/dynamic_link_repository_impl.dart';
import 'package:data/repository/enter_address/home_address_dialog_repository_impl.dart';
import 'package:data/repository/fatca_crs/fatca_crs_repository_impl.dart';
import 'package:data/repository/forget_password/forget_password_repository_impl.dart';
import 'package:data/repository/id_card/id_card_repository_impl.dart';
import 'package:data/repository/infobip_audio/infobip_audio_repository_impl.dart';
import 'package:data/repository/infobip_audio/infobip_message_repository_impl.dart';
import 'package:data/repository/kyc/kyc_repository_impl.dart';
import 'package:data/repository/manage_contacts/manage_contacts_repository_impl.dart';
import 'package:data/repository/payment/payment_repository_impl.dart';
import 'package:data/repository/register/register_repository_impl.dart';
import 'package:data/repository/register/register_step_four_repository_impl.dart';
import 'package:data/repository/register/register_step_three_repository_impl.dart';
import 'package:data/repository/upload_document/upload_document_repository_impl.dart';
import 'package:data/repository/user/user_repository_impl.dart';
import 'package:data/repository/utility/utility_repository_impl.dart';
import 'package:domain/repository/account/account_repository.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/repository/activity/activity_repository.dart';
import 'package:domain/repository/app_flyer_repository/app_flyer_repository.dart';
import 'package:domain/repository/bank_smart/bank_smart_repository.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/repository/card_processing/card_processing_repository.dart';
import 'package:domain/repository/change_device/change_device_repository.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/repository/dashboard/dashboard_repository.dart';
import 'package:domain/repository/dynamic_link/dynamic_link_repository.dart';
import 'package:domain/repository/enter_address/home_address_dialog_repository.dart';
import 'package:domain/repository/fatca_crs/fatca_crs_repository.dart';
import 'package:domain/repository/forget_password/forget_password_repository.dart';
import 'package:domain/repository/help_center/help_canter.dart';
import 'package:domain/repository/help_center/infobip_message_repository.dart';
import 'package:domain/repository/id_card/id_card_repository.dart';
import 'package:domain/repository/kyc/kyc_repository.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/repository/register/register_repository.dart';
import 'package:domain/repository/register/register_step_four_repository.dart';
import 'package:domain/repository/register/register_step_three_repository.dart';
import 'package:domain/repository/upload_document/upload_document_repository.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/repository/utility/utility_repository.dart';
import 'package:riverpod/riverpod.dart';

/// inject [UserRepository] provider
var userRepoProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(
    ref.read(userRemoteDSProvider),
    ref.read(userLocalDSProvider),
    ref.read(dioProvider),
  ),
);

/// inject [CountryRepository] provider
var countryRepoProvider = Provider<CountryRepository>(
  (ref) =>
      CountryRepositoryImpl(ref.read(countryLocalDataProvider), ref.read(countryRemoteDataSourceProvider)),
);

var registerRepoProvider = Provider<RegisterRepository>(
  (ref) => RegisterRepositoryImpl(ref.read(registerRemoteDS)),
);

var registerStepThreeRepoProvider = Provider<RegisterStepThreeRepository>(
  (ref) => RegisterStepThreeRepositoryImpl(ref.read(registerStepThreeRemoteDS)),
);

var registerStepFourRepoProvider = Provider<RegisterStepFourRepository>(
  (ref) => RegisterStepFourRepositoryImpl(ref.read(registerStepFourRemoteDS)),
);

var uploadDocumentRepositoryProvider = Provider<UploadDocumentRepository>((ref) =>
    UploadDocumentRepositoryImpl(
        ref.read(uploadDocumentDataSourceProvider), ref.read(uploadDocumentRemoteDataSourceProvider)));

var homeAddressDialogRepositoryProvider = Provider<HomeAddressDialogRepository>(
    (ref) => HomeAddressDialogRepositoryImpl(ref.read(homeAddressDialogDataSourceProvider)));

/// inject [KYCRepository] provider
var kycRepositoryProvider = Provider<KYCRepository>((ref) => KYCRepositoryImpl(ref.read(kycRemoteDS)));

/// inject [CardProcessingRepository] provider
var cardProcessingRepository = Provider<CardProcessingRepository>(
    (ref) => CardProcessingRepositoryImpl(ref.read(cardProcessingDataSourceProvider)));

/// inject [IdCardRepository] provider
var idCardRepositoryProvider =
    Provider<IdCardRepository>((ref) => IdCardRepositoryImpl(ref.read(idCardRemoteDS)));

/// inject [BankSmartRepository] provider
var bankSmartRepositoryProvider =
    Provider<BankSmartRepository>((ref) => BankSmartRepositoryImpl(ref.read(bankSmartRemoteDS)));

/// inject [FatcaCrsRepository] provider
var fatcaCrsRepositoryProvider =
    Provider<FatcaCrsRepository>((ref) => FatcaCrsRepositoryImpl(ref.read(fatcaCrsRemoteDS)));

/// inject [AccountRepository] provider
var accountRepositoryProvider =
    Provider<AccountRepository>((ref) => AccountRepositoryImpl(ref.read(accountRemoteDS)));

/// inject [CardRepository] provider
var cardRepositoryProvider =
    Provider<CardRepository>((ref) => CardRepositoryImpl(ref.read(cardRemoteDataSourceProvider)));

/// inject [AccountSettingsRepository] provider
var accountSettingRepositoryProvider = Provider<AccountSettingsRepository>(
    (ref) => AccountSettingsRepositoryImpl(ref.read(accountSettingDataSourceProvider)));

/// inject [ManageContactRepository] provider
var manageContactRepositoryProvider = Provider<ManageContactRepository>(
    (ref) => ManageContactsRepositoryImpl(ref.read(contactsDataSourceProvider)));

/// inject [ManageContactRepository] provider
var dashboardRepositoryProvider =
    Provider<DashboardRepository>((ref) => DashboardRepositoryImpl(ref.read(dashboardDataSourceProvider)));

/// inject [PaymentRepository] provider
var paymentRepositoryProvider =
    Provider<PaymentRepository>((ref) => PaymentRepositoryImpl(ref.read(paymentDataSourceProvider)));

/// inject [HelpCenterRepository] provider
var helpCenterRepositoryProvider = Provider<HelpCenterRepository>(
    (ref) => InfobipAudioRepositoryImpl(ref.read(infobipDatasourceProvider), ref.read(userRepoProvider)));

/// inject [InfobipMessageRepository] provider
var infobipMessagingRepositoryProvider = Provider<InfobipMessageRepository>((ref) =>
    InfobipMessageRepositoryImpl(ref.read(infobipMessagingDatasourceProvider), ref.read(userRepoProvider)));

/// inject [ForgetPasswordRepository] provider
var forgetPasswordRepositoryProvider = Provider<ForgetPasswordRepository>(
    (ref) => ForgetPasswordRepositoryImpl(ref.read(forgetPasswordDataSourceProvider)));

/// inject [UtilityRepository] provider
var utilityRepositoryProvider =
    Provider<UtilityRepository>((ref) => UtilityRepositoryImpl(ref.read(utilityDataSourceProvider)));

/// inject [ActivityRepository] provider
var activityRepositoryProvider =
    Provider<ActivityRepository>((ref) => ActivityRepositoryImpl(ref.read(activityDataSourceProvider)));

/// inject [ChangeDeviceRepository] provider
var deviceChangeRepositoryProvider = Provider<ChangeDeviceRepository>(
    (ref) => DeviceChangeRepositoryImpl(ref.read(deviceChangeSourceProvider)));

/// inject [ChangeDeviceRepository] provider
var appFlyerRepositoryProvider =
    Provider<AppFlyerRepository>((ref) => AppFlyerRepositoryImpl(ref.read(appFlyerSdkDatasourceProvider)));

var dynamicLinkRepositoryProvider = Provider<DynamicLinkRepository>(
    (ref) => DynamicLinkRepositoryImpl(ref.read(dynamicLinkDataSourceImplProvider)));
