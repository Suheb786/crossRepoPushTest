import 'package:country_calling_code_picker/picker.dart';
import 'package:data/entity/remote/country/country_list/country_list_response_entity.dart';
import 'package:data/entity/remote/country/get_allowed_country/get_allowed_country_response_entity.dart';
import 'package:data/entity/remote/country/get_allowed_issuer/get_allowed_issuer_response_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:retrofit/retrofit.dart';

abstract class CountryRemoteDs {
  Future<HttpResponse<CountryListResponseEntity>> getCountryList();

  Future<HttpResponse<GetAllowedCountryResponseEntity>>
      getAllowedCodeCountryList();

  Future<HttpResponse<GetAllowedIssuerResponseEntity>> fetchAllowedIssuers();
}

mixin CountryLocalDs {
  Future<List<Country>> fetchCountries({required BuildContext context});

  Future<Country?> fetchCountryByCountryCode(
      {required BuildContext context, String? countryCode});
}
