import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:data/source/country/country_datasource.dart';
import 'package:flutter/widgets.dart';

class CountryLocalDsImpl with CountryLocalDs {
  @override
  Future<List<Country>> fetchCountries({required BuildContext context}) {
    return getCountries(context);
  }
}
