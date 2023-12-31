import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/dashboard/atms_response_entity.dart';
import 'package:data/entity/remote/dashboard/dashboard_data_request.dart';
import 'package:data/entity/remote/dashboard/dashboard_data_response_entity.dart';
import 'package:data/entity/remote/dashboard/placeholder/get_placeholder_request_entity.dart';
import 'package:data/entity/remote/dashboard/placeholder/placeholder_response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/dashboard/dashboard_datasource.dart';
import 'package:retrofit/dio.dart';

class DashboardRemoteDsImpl extends DashboardRemoteDs {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  DashboardRemoteDsImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<DashboardDataResponseEntity>> getDashboardData() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getDashboardData(DashboardDataRequest(getToken: true, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<AtmsResponseEntity>> getAtms() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getAtms(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<PlaceholderResponseEntity>> getPlaceholder({int? placeholderId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getPlaceholder(
        GetPlaceholderRequestEntity(baseData: baseData.toJson(), placeholderId: placeholderId ?? 0));
  }
}
