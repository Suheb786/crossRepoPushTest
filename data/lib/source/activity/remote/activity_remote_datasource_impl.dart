import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/activity/activity_request_entity.dart';
import 'package:data/entity/remote/activity/activity_response_entity.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/activity/activity_datasource.dart';
import 'package:retrofit/dio.dart';

class ActivityRemoteDsImpl extends ActivityRemoteDs {
  final ApiService _apiService;
  final DeviceInfoHelper deviceInfoHelper;

  ActivityRemoteDsImpl(this._apiService, this.deviceInfoHelper);

  @override
  Future<HttpResponse<ActivityResponseEntity>> getActivity(
      num noOfDays, String isDebit) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.getActivity(ActivityRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        isDebit: isDebit,
        noOfDays: noOfDays));
  }
}
