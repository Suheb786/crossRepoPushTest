import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class ChangeMyNumberDialogViewModel extends BasePageViewModel {
  ///controllers and keys
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<AppTextFieldState> mobileNumberKey =
      GlobalKey(debugLabel: "mobileNumber");

  CountryData countryData = CountryData();

  ///selected country response holder
  BehaviorSubject<CountryData> _selectedCountryResponse =
      BehaviorSubject.seeded(CountryData());

  ///get allowed code country response stream
  Stream<CountryData> get getSelectedCountryStream =>
      _selectedCountryResponse.stream;

  void setSelectedCountry(CountryData data) {
    _selectedCountryResponse.safeAdd(data);
  }
}
