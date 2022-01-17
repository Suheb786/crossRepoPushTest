import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/forget_password/check_forget_password_request_entity.dart';
import 'package:data/entity/remote/forget_password/check_forget_password_response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/forget_password/forget_password_datasource.dart';
import 'package:retrofit/dio.dart';

class ForgetPasswordRemoteDsImpl extends ForgetPasswordRemoteDs {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  ForgetPasswordRemoteDsImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<CheckForgetPasswordResponseEntity>> checkForgetPassword(
      {required String? email,
      required String? expiryDate,
      required String? nationalId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkForgetPassword(CheckForgetPasswordRequestEntity(
        email: email,
        idNo: nationalId,
        idExpiry: expiryDate,
        baseData: baseData.toJson()));
  }
}
