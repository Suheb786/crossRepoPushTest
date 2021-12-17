import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/account/check_agent_status_request_entity.dart';
import 'package:data/entity/remote/account/check_agent_status_response_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_request_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_response_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_request_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_response_entity.dart';
import 'package:data/entity/remote/account/doc_status_request_entity.dart';
import 'package:data/entity/remote/account/doc_status_response_entity.dart';
import 'package:data/entity/remote/account/save_customer_schedule_time_request_entity.dart';
import 'package:data/entity/remote/account/save_customer_schedule_time_response_entity.dart';
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

  @override
  Future<HttpResponse<CheckOtherNationalityStatusResponseEntity>>
      checkOtherNationalityStatus({bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkOtherNationalityStatus(
        CheckOtherNationalityStatusRequestEntity(
            baseData: baseData.toJson(), getToken: getToken));
  }

  @override
  Future<HttpResponse<DocStatusResponseEntity>> docStatus() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.docStatus(
        DocStatusRequestEntity(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<CheckAgentStatusResponseEntity>>
      checkAgentStatus() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkAgentStatus(CheckAgentStatusRequestEntity(
        baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<SaveCustomerScheduleTimeResponseEntity>>
      saveCustomerVideoCallScheduleTime(
          {String? scheduleDate, String? scheduleTime}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveCustomerVideoCallScheduleTime(
        SaveCustomerScheduleTimeRequestEntity(
            baseData: baseData.toJson(),
            scheduleTime: scheduleTime,
            scheduleDate: scheduleDate));
  }
}
