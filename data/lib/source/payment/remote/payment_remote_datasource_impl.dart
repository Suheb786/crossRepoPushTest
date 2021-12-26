import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_content_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_request_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/payment/payment_datasource.dart';
import 'package:retrofit/dio.dart';

class PaymentRemoteDataSourceImpl extends PaymentRemoteDs {
  final ApiService _apiService;
  final DeviceInfoHelper deviceInfoHelper;

  PaymentRemoteDataSourceImpl(this._apiService, this.deviceInfoHelper);

  @override
  Future<HttpResponse<GetAccountByAliasContentResponseEntity>>
      getAccountByAlias(String value, String currency) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.getAccountByAlias(GetAccountByAliasRequestEntity(
        baseData: baseData.toJson(),
        value: value,
        currency: currency,
        getToken: true));
  }
}
