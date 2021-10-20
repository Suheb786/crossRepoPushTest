import 'package:data/source/country/country_datasource.dart';
import 'package:data/source/country/local/country_local_ds_impl.dart';
import 'package:data/source/enter_address/home_address_dialog_data_source.dart';
import 'package:data/source/enter_address/local/home_address_dialog_data_source_impl.dart';
import 'package:data/source/upload_document/local/upload_document_local_ds.dart';
import 'package:data/source/upload_document/upload_document_datasource.dart';
import 'package:device_info/device_info.dart';
import 'package:riverpod/riverpod.dart';

var deviceInfoPluginProvider = Provider<DeviceInfoPlugin>(
  (ref) => DeviceInfoPlugin(),
);

var countryLocalDataProvider = Provider<CountryLocalDs>(
  (ref) => CountryLocalDsImpl(),
);

var uploadDocumentDataSourceProvider =
    Provider<UploadDocumentLocalDS>((ref) => UploadDocumentLocalDSImpl());

var homeAddressDialogDataSourceProvider = Provider<HomeAddressDialogDataSource>(
    (ref) => HomeAddressDialogDataSourceImpl());
