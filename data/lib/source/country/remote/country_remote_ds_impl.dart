import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/country/city_list/city_list_request_entity.dart';
import 'package:data/entity/remote/country/city_list/city_list_response_entity.dart';
import 'package:data/entity/remote/country/country_list/country_list_request_entity.dart';
import 'package:data/entity/remote/country/country_list/country_list_response_entity.dart';
import 'package:data/entity/remote/country/get_allowed_country/get_allowed_country_request_entity.dart';
import 'package:data/entity/remote/country/get_allowed_country/get_allowed_country_response_entity.dart';
import 'package:data/entity/remote/country/get_allowed_issuer/get_allowed_issuer_response_entity.dart';
import 'package:data/entity/remote/country/state_list/state_list_request_entity.dart';
import 'package:data/entity/remote/country/state_list/state_list_response_entity.dart';
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
    return _apiService.getCountryList(CountryListRequestEntity(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<GetAllowedCountryResponseEntity>> getAllowedCodeCountryList() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    Map<String, dynamic> content = Map();
    content.putIfAbsent("UniqueId", () => DateTime.now().microsecondsSinceEpoch.toString());

    return _apiService.getAllowedCodeCountryList(
        GetAllowedCountryRequestEntity(baseData: baseData.toJson(), content: content));
  }

  @override
  Future<HttpResponse<StateListResponseEntity>> getStateList({String? isoCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService
        .getStateList(StateListRequestEntity(baseData: baseData.toJson(), getToken: true, isoCode: isoCode));
  }

  @override
  Future<HttpResponse<CityListResponseEntity>> getCityList({String? stateID, String? isoCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.getCityList(CityListRequestEntity(
        baseData: baseData.toJson(), getToken: true, isoCode: isoCode, stateID: stateID));
  }

  @override
  Future<HttpResponse<CityListResponseEntity>> getCitiesByCountry({String? stateID, String? isoCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    return _apiService.getCitiesByCountry(CityListRequestEntity(
        baseData: baseData.toJson(), getToken: true, isoCode: isoCode, stateID: stateID));
  }

  @override
  Future<HttpResponse<GetAllowedIssuerResponseEntity>> fetchAllowedIssuers() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.fetchAllowedIssuers(BaseRequest(baseData: baseData.toJson()));
  }
}
