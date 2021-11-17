import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/ahwal/get_ahwal_details_request.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/id_card/id_card_datasource.dart';

class IdCardRemoteDSImpl extends IdCardRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  IdCardRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<String> getAhwalDetails({String? idNo}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getAhwalDetails(
        GetAhwalDetailsRequest(baseData: baseData, idNo: idNo));
  }
}
