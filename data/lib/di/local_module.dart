import 'package:data/source/country/country_datasource.dart';
import 'package:data/source/country/local/country_local_ds_impl.dart';
import 'package:device_info/device_info.dart';
import 'package:riverpod/riverpod.dart';

var deviceInfoPluginProvider = Provider<DeviceInfoPlugin>(
  (ref) => DeviceInfoPlugin(),
);

var countryLocalDataProvider = Provider<CountryLocalDs>(
  (ref) => CountryLocalDsImpl(),
);
