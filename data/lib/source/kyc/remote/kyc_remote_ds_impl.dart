import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/kyc/check_kyc_status_response_entity.dart';
import 'package:data/entity/remote/kyc/kyc_status_request.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/kyc/kyc_datasource.dart';
import 'package:retrofit/dio.dart';

class KYCRemoteDSImpl extends KYCRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  KYCRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<CheckKycStatusResponseEntity>> checkKYCStatus() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.checkKYCStatus(
        KYCStatusRequest(baseData: baseData.toJson(), getToken: true));
  }
}
