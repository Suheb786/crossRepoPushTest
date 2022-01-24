import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/source/utility/utility_datasource.dart';

class UtilityDataSourceImpl extends UtilityDataSource {
  final DeviceInfoHelper _deviceInfoHelper;

  UtilityDataSourceImpl(this._deviceInfoHelper);

  @override
  Future<bool> checkDeviceCompatibility() async {
    return await _deviceInfoHelper.checkDeviceSecurity();
  }
}
