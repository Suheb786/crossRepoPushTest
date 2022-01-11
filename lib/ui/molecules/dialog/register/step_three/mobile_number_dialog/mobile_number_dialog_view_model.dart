import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class MobileNumberDialogViewModel extends BasePageViewModel {
  final TextEditingController mobileNumberSearchController =
      TextEditingController();

  final FixedExtentScrollController scrollController =
      FixedExtentScrollController();

  CountryData? selectedCountryData = CountryData();

  ///current selected index subject holder
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  ///get country list response holder
  BehaviorSubject<Resource<List<CountryData>>> _getAllowedCountryCodeResponse =
      BehaviorSubject();

  ///get country list response stream
  Stream<Resource<List<CountryData>>> get getAllowedCountryCodeStream =>
      _getAllowedCountryCodeResponse.stream;

  List<CountryData>? searchResult = [];

  List<CountryData>? allCountryList = [];

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  void selectMobileNumber(int index) {
    List<CountryData>? countryList = _getAllowedCountryCodeResponse.value.data;
    if (countryList!.isNotEmpty) {
      countryList.forEach((element) {
        element.isSelected = false;
      });
      countryList.elementAt(index).isSelected = true;
      selectedCountryData =
          countryList.firstWhere((element) => element.isSelected);
      _getAllowedCountryCodeResponse
          .safeAdd(Resource.success(data: countryList));
    }
  }

  void searchMobileNumber(String? searchText) {
    searchResult!.clear();
    List<CountryData>? countryList = allCountryList;
    if (searchText!.isNotEmpty) {
      for (int i = 0; i < countryList!.length; i++) {
        CountryData country = countryList[i];
        if (country.countryName!
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          searchResult!.add(country);
        }
      }
      _getAllowedCountryCodeResponse
          .safeAdd(Resource.success(data: searchResult));
      selectMobileNumber(0);
    } else {
      _getAllowedCountryCodeResponse
          .safeAdd(Resource.success(data: allCountryList));
    }
  }

  setResponse(List<CountryData> data) {
    _getAllowedCountryCodeResponse.safeAdd(Resource.success(data: data));
    allCountryList = data;
    selectMobileNumber(0);
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    _getAllowedCountryCodeResponse.close();
    super.dispose();
  }
}
