import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/widgets.dart';

mixin CountryRemoteDs {}

mixin CountryLocalDs {
  Future<List<Country>> fetchCountries({required BuildContext context});
}
