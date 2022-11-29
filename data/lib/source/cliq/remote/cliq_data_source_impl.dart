import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/cliq/delete_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/re_activate_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/suspend_cliq_id_request_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/cliq/clip_data_source.dart';
import 'package:retrofit/dio.dart';

class CliqRemoteDataSourceImpl extends CliqDataSource {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  CliqRemoteDataSourceImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<ResponseEntity>> editCliqID(
      {required bool isAlias,
      required String aliasId,
      required String aliasValue,
      required String OtpCode,
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.editCliqID(EditCliqIdRequestEntity(
        isAlias: isAlias,
        aliasValue: aliasValue,
        aliasId: aliasId,
        getToken: getToken,
        OtpCode: OtpCode,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> deleteCliqId({required String aliasId, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.deleteCliqId(
        DeleteCliqIdRequestEntity(aliasId: aliasId, getToken: getToken, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> reActivateCliqId(
      {required String aliasId, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.reActivateCliqId(
        ReActivateCliqIdRequestEntity(getToken: getToken, aliasId: aliasId, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> suspendCliqId(
      {required String aliasId, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.suspendCliqId(
        SuspendCliqIdRequestEntity(aliasId: aliasId, getToken: getToken, baseData: baseData.toJson()));
  }
}
