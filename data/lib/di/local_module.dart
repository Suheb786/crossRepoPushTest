import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/rsa_key_helper.dart';
import 'package:data/helper/app_flyer_helper.dart';
import 'package:data/helper/dynamic_link.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/infobip_audio/infobip_audio_service.dart';
import 'package:data/infobip_audio/infobip_message_service.dart';
import 'package:data/local_auth/bio_matric/bio_metric_service.dart';
import 'package:data/source/app_flyer_source/app_flyer_datasource.dart';
import 'package:data/source/app_flyer_source/remote/app_flyer_datasource_impl.dart';
import 'package:data/source/card_processing/card_processing_data_source.dart';
import 'package:data/source/card_processing/local/card_processing_local_ds_impl.dart';
import 'package:data/source/dynamic_link/dynamic_link_datasource.dart';
import 'package:data/source/dynamic_link/remote/dynamic_link_datasource_impl.dart';
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
import 'package:infobipplugin/infobipplugin.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod/riverpod.dart';

import '../network/local_session_service.dart';

final localAuthenticationProvider = Provider<LocalAuthentication>(
  (ref) => LocalAuthentication(),
);

final bioMetricSourceProvider = Provider<BioMetricService>(
  (ref) => BioMetricService(
    ref.read(localAuthenticationProvider),
  ),
);

final localSessionService = Provider<LocalSessionService>(
  (ref) => LocalSessionService(),
);

var userLocalDSProvider = Provider<UserLocalDS>(
  (ref) => UserLocalDSImpl(
      ref.read(bioMetricSourceProvider), ref.read(secureStorageProvider), ref.read(localSessionService)),
);

var uploadDocumentDataSourceProvider = Provider<UploadDocumentLocalDS>((ref) => UploadDocumentLocalDSImpl());

///Card Processing data source
var cardProcessingDataSourceProvider = Provider<CardProcessingLocalDs>((ref) => CardProcessingLocalDsImpl());

var deviceInfoHelperProvider = Provider<DeviceInfoHelper>((ref) => DeviceInfoHelper());

var utilityDataSourceProvider =
    Provider<UtilityDataSource>((ref) => UtilityDataSourceImpl(ref.read(deviceInfoHelperProvider)));

// ///cryptoUtil provider
// final crytoUtilProvider = Provider<CryptoUtil>(
//   (ref) => CryptoUtil(ref.read(userRepoProvider),
//       //ref.read(rsaHelperProvider)
//   ),
// );

final infobipAudioProvider = Provider<InfoBip>(
  (ref) => InfoBip(),
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

final infobipDatasourceProvider =
    Provider<InfobipAudioLocalDs>((ref) => InfobipAudioDSImpl(ref.read(infobipAudioServiceProvider)));

//
// final infobipMessagingProvider = Provider<InfobipMobilemessaging>(
//   (ref) => InfobipMobilemessaging(),
// );

final infobipMessagingServiceProvider = Provider<InfobipMessageService>((ref) => InfobipMessageService());

final infobipMessagingDatasourceProvider =
    Provider<InfobipMessageLocalDs>((ref) => InfobipMessageDSImpl(ref.read(infobipMessagingServiceProvider)));

final secureStorageProvider = Provider<SecureStorageHelper>(
  (ref) => SecureStorageHelper(),
);

final appFlyerHelper = Provider<AppFlyerHelper>(
  (ref) => AppFlyerHelper(),
);

final appFlyerSdkDatasourceProvider =
    Provider<AppFlyerDataSource>((ref) => AppFlyerDataSourceImpl(ref.read(appFlyerHelper)));

final dynamicLinksService = Provider<DynamicLinksService>(
  (ref) => DynamicLinksService(),
);

final dynamicLinkDataSourceImplProvider =
    Provider<DynamicLinkDataSource>((ref) => DynamicLinkDataSourceImpl(ref.read(dynamicLinksService)));
