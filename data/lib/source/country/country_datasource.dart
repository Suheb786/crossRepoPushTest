import 'package:data/entity/remote/country/city_list/city_list_response_entity.dart';
import 'package:data/entity/remote/country/country_list/country_list_response_entity.dart';
import 'package:data/entity/remote/country/get_allowed_country/get_allowed_country_response_entity.dart';
import 'package:data/entity/remote/country/get_allowed_issuer/get_allowed_issuer_response_entity.dart';
import 'package:data/entity/remote/country/state_list/state_list_response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class CountryRemoteDs {
  Future<HttpResponse<CountryListResponseEntity>> getCountryList();

  Future<HttpResponse<GetAllowedCountryResponseEntity>> getAllowedCodeCountryList();

  Future<HttpResponse<StateListResponseEntity>> getStateList({String? isoCode});

  Future<HttpResponse<CityListResponseEntity>> getCityList({String? stateID, String? isoCode});

  Future<HttpResponse<CityListResponseEntity>> getCitiesByCountry({String? stateID, String? isoCode});

  Future<HttpResponse<GetAllowedIssuerResponseEntity>> fetchAllowedIssuers();
}
