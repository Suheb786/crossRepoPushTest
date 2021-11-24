import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/account/check_videocall_status_request_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_response_entity.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/account/account_datasource.dart';
import 'package:retrofit/dio.dart';

class AccountRemoteDSImpl extends AccountRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  AccountRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<CheckVideoCallStatusResponseEntity>> checkVideoCallStatus(
      {bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkVideoCallStatus(CheckVideoCallStatusRequestEntity(
        baseData: baseData.toJson(), getToken: getToken));
  }
}
