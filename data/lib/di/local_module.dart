import 'package:data/db/floor/database_properties.dart';
import 'package:data/db/floor/floor_db_service.dart';
import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/rsa_key_helper.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/infobip_audio/infobip_audio_service.dart';
import 'package:data/infobip_audio/infobip_message_service.dart';
import 'package:data/local_auth/bio_matric/bio_metric_service.dart';
import 'package:data/source/card_processing/card_processing_data_source.dart';
import 'package:data/source/card_processing/local/card_processing_local_ds_impl.dart';
import 'package:data/source/country/country_datasource.dart';
import 'package:data/source/country/local/country_local_ds_impl.dart';
import 'package:data/source/enter_address/home_address_dialog_ds.dart';
import 'package:data/source/enter_address/local/home_address_dialog_data_source_impl.dart';
import 'package:data/source/infobip_audio/infobip_audio_datasource.dart';
import 'package:data/source/infobip_audio/infobip_message_datasource.dart';
import 'package:data/source/infobip_audio/local/infobip_audio_local_datasource_implementation.dart';
import 'package:data/source/infobip_audio/local/infobip_message_local_datasource_implementation.dart';
import 'package:data/source/upload_document/local/upload_document_local_ds.dart';
import 'package:data/source/upload_document/upload_document_datasource.dart';
import 'package:data/source/user/local/user_local_ds_impl.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:data/source/utility/local/utility_datasource_impl.dart';
import 'package:data/source/utility/utility_datasource.dart';
import 'package:device_info/device_info.dart';
import 'package:infobip_plugin/infobip_plugin.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod/riverpod.dart';

final floorAppDatabase = Provider<FloorDbService>(
  (ref) => FloorDbService(
    DatabaseProperties.DB_NAME,
  ),
);

final localAuthenticationProvider = Provider<LocalAuthentication>(
  (ref) => LocalAuthentication(),
);

final bioMetricSourceProvider = Provider<BioMetricService>(
  (ref) => BioMetricService(
    ref.read(localAuthenticationProvider),
  ),
);

var userLocalDSProvider = Provider<UserLocalDS>(
  (ref) => UserLocalDSImpl(ref.read(floorAppDatabase),
      ref.read(bioMetricSourceProvider), ref.read(secureStorageProvider)),
);

var deviceInfoPluginProvider = Provider<DeviceInfoPlugin>(
  (ref) => DeviceInfoPlugin(),
);

var countryLocalDataProvider = Provider<CountryLocalDs>(
  (ref) => CountryLocalDsImpl(),
);

var uploadDocumentDataSourceProvider =
    Provider<UploadDocumentLocalDS>((ref) => UploadDocumentLocalDSImpl());

///Card Processing data source
var cardProcessingDataSourceProvider =
    Provider<CardProcessingLocalDs>((ref) => CardProcessingLocalDsImpl());

var homeAddressDialogDataSourceProvider =
    Provider<HomeAddressDialogDS>((ref) => HomeAddressDialogDSImpl());

var deviceInfoHelperProvider =
    Provider<DeviceInfoHelper>((ref) => DeviceInfoHelper());

var utilityDataSourceProvider = Provider<UtilityDataSource>(
    (ref) => UtilityDataSourceImpl(ref.read(deviceInfoHelperProvider)));

// ///cryptoUtil provider
// final crytoUtilProvider = Provider<CryptoUtil>(
//   (ref) => CryptoUtil(ref.read(userRepoProvider),
//       //ref.read(rsaHelperProvider)
//   ),
// );

final infobipAudioProvider = Provider<InfobipPlugin>(
  (ref) => InfobipPlugin(),
);

final infobipAudioServiceProvider = Provider<InfoBipAudioService>(
  (ref) => InfoBipAudioService(
    ref.read(infobipAudioProvider),
  ),
);

///rsa Helper provider
final rsaHelperProvider = Provider<RsaKeyHelper>(
  (ref) => RsaKeyHelper(),
);

final infobipDatasourceProvider = Provider<InfobipAudioLocalDs>(
    (ref) => InfobipAudioDSImpl(ref.read(infobipAudioServiceProvider)));

//
// final infobipMessagingProvider = Provider<InfobipMobilemessaging>(
//   (ref) => InfobipMobilemessaging(),
// );

final infobipMessagingServiceProvider =
    Provider<InfobipMessageService>((ref) => InfobipMessageService());

final infobipMessagingDatasourceProvider = Provider<InfobipMessageLocalDs>(
    (ref) => InfobipMessageDSImpl(ref.read(infobipMessagingServiceProvider)));

final secureStorageProvider = Provider<SecureStorageHelper>(
  (ref) => SecureStorageHelper(),
);
