import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/country/country_list/country_list_request_entity.dart';
import 'package:data/entity/remote/country/country_list/country_list_response_entity.dart';
import 'package:data/entity/remote/country/get_allowed_country/get_allowed_country_request_entity.dart';
import 'package:data/entity/remote/country/get_allowed_country/get_allowed_country_response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/country/country_datasource.dart';
import 'package:retrofit/dio.dart';

class CountryRemoteDSImpl extends CountryRemoteDs {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  CountryRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<CountryListResponseEntity>> getCountryList() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCountryList(
        CountryListRequestEntity(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<
      GetAllowedCountryResponseEntity>> getAllowedCodeCountryList() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    Map<String, dynamic> content = Map();
    content.putIfAbsent(
        "UniqueId", () =>
        DateTime
            .now()
            .microsecondsSinceEpoch
            .toString());

    return _apiService.getAllowedCodeCountryList(
        GetAllowedCountryRequestEntity(
            baseData: baseData.toJson(), content: content));
    }
}
