import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/user/check_user_email_request.dart';
import 'package:data/entity/remote/user/login_user_request.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/user/user_data_sources.dart';

class UserRemoteDSImpl extends UserRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  UserRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<String> checkUserName({String? email}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .checkUserName(CheckUserEmailRequest(baseData: baseData, email: email));
  }

  @override
  Future<String> loginUser(
      {required String email, required String password}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.loginUser(
        LoginUserRequest(baseData: baseData, email: email, password: password));
  }
}
