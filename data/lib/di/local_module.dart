import 'package:data/db/floor/database_properties.dart';
import 'package:data/db/floor/floor_db_service.dart';
import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/source/country/country_datasource.dart';
import 'package:data/source/country/local/country_local_ds_impl.dart';
import 'package:data/source/enter_address/home_address_dialog_ds.dart';
import 'package:data/source/enter_address/local/home_address_dialog_data_source_impl.dart';
import 'package:data/source/upload_document/local/upload_document_local_ds.dart';
import 'package:data/source/upload_document/upload_document_datasource.dart';
import 'package:data/source/user/local/user_local_ds_impl.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:device_info/device_info.dart';
import 'package:riverpod/riverpod.dart';

final floorAppDatabase = Provider<FloorDbService>(
  (ref) => FloorDbService(
    DatabaseProperties.DB_NAME,
  ),
);

var userLocalDSProvider = Provider<UserLocalDS>(
  (ref) => UserLocalDSImpl(
    ref.read(floorAppDatabase),
  ),
);

var deviceInfoPluginProvider = Provider<DeviceInfoPlugin>(
  (ref) => DeviceInfoPlugin(),
);

var countryLocalDataProvider = Provider<CountryLocalDs>(
  (ref) => CountryLocalDsImpl(),
);

var uploadDocumentDataSourceProvider =
    Provider<UploadDocumentLocalDS>((ref) => UploadDocumentLocalDSImpl());

var homeAddressDialogDataSourceProvider =
    Provider<HomeAddressDialogDS>((ref) => HomeAddressDialogDSImpl());

var deviceInfoHelperProvider =
    Provider<DeviceInfoHelper>((ref) => DeviceInfoHelper());
