import 'package:data/entity/remote/sub_account/add_sub_account/add_sub_account_request_entity.dart';
import 'package:data/entity/remote/sub_account/update_nick_name/update_nick_name_request_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/sub_account/sub_account_datasource.dart';
import 'package:domain/usecase/sub_account/add_account_usecase.dart';
import 'package:domain/usecase/sub_account/update_nick_name_sub_account_usecase.dart';
import 'package:retrofit/dio.dart';
import 'package:domain/usecase/sub_account/deactivate_sub_account_usecase.dart';

import '../../../entity/local/base/device_helper.dart';
import '../../../entity/remote/base/base_class.dart';
import '../../../entity/remote/sub_account/close_sub_account/close_sub_account_request_entity.dart';

class SubAccountDataSourceImpl extends SubAccountDataSource {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  SubAccountDataSourceImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<ResponseEntity>> deActivateSubAccount(
      {required CloseSubAccountUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.closeSubAccount(
      CloseSubAccountRequestEntity(
        accountNo: params.accountNo,
        iban: params.iban,
        getToken: params.getToken,
        baseClass: baseData.toJson(),
      ),
    );
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateNickNameSubAccount(
      {required UpdateNickNameSubAccountUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateNickNameSubAccount(
      UpdateNickNameSubAccountRequestEntity(
        nickName: params.NickName,
        accountNo: params.accountNo,
        getToken: params.GetToken,
        baseClass: baseData.toJson(),
      ),
    );
  }

  @override
  Future<HttpResponse<ResponseEntity>> addSubAccount({required AddSubAccountUseCaseParams params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.addSubAccount(
      AddSubAccountRequestEntity(
        nickName: params.NickName,
        subAccountNo: params.SubAccountNo,
        getToken: params.GetToken,
        baseClass: baseData.toJson(),
      ),
    );
  }
}
