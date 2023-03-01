import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/country_list/country_list_content_data.dart';
import 'package:domain/usecase/country/fetch_countries_usecase.dart';
import 'package:domain/usecase/country/get_countries_list_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CountryDialogViewModel extends BasePageViewModel {
  final FetchCountriesUseCase _fetchCountriesUseCase;

  final GetCountriesListUseCase _getCountriesListUseCase;

  final TextEditingController countrySearchController = TextEditingController();

  FixedExtentScrollController scrollController = FixedExtentScrollController();

  CountryData? initialSelectedCountry = CountryData();

  CountryData? selectedCountry = CountryData();

  ///current selected index subject holder
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  List<CountryData>? searchResult = [];

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  ///get country list request holder
  PublishSubject<GetCountriesListUseCaseParams> _getCountryListRequest = PublishSubject();

  ///get country list response holder
  BehaviorSubject<Resource<CountryListContentData>> _getCountryListResponse = BehaviorSubject();

  ///get country list response stream
  Stream<Resource<List<CountryData>>> get getCountryListStream => _searchCountryResponse.stream;

  ///search country response holder
  BehaviorSubject<Resource<List<CountryData>>> _searchCountryResponse = BehaviorSubject();

  bool isDataAvailable = false;

  CountryDialogViewModel(this._fetchCountriesUseCase, this._getCountriesListUseCase) {
    _getCountryListRequest.listen((value) {
      RequestManager(value, createCall: () => _getCountriesListUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getCountryListResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          event.data!.content!.countryData!.sort((a, b) {
            return a.countryName!.toLowerCase().compareTo(b.countryName!.toLowerCase());
          });
          _searchCountryResponse.safeAdd(Resource.success(data: event.data!.content!.countryData!));

          selectedCountry = event.data!.content!.countryData!.firstWhere(
              (element) => element.isoCode3 == 'JOR',
              orElse: () => event.data!.content!.countryData!.first);
          // int? index;
          // event.data!.content!.countryData!.forEach((element) {
          //   print("here");
          //   if (element.countryName!.toUpperCase() == "JORDAN") {
          //     print("got it");
          //     index = event.data!.content!.countryData!.indexOf(element);
          //   }
          // });
          initialSelectedCountry = selectedCountry;
          scrollController = FixedExtentScrollController(
              initialItem: event.data!.content!.countryData!.indexOf(selectedCountry!));
          selectCountry(event.data!.content!.countryData!.indexOf(selectedCountry!));
          isDataAvailable = true;
        }
      });
    });
  }

  void getCountries() {
    if (!isDataAvailable) {
      _getCountryListRequest.safeAdd(GetCountriesListUseCaseParams());
    }
  }

  void selectCountry(int index) {
    List<CountryData>? countryList = _searchCountryResponse.value.data;
    if (countryList!.isNotEmpty) {
      countryList.forEach((element) {
        element.isSelected = false;
      });
      countryList.elementAt(index).isSelected = true;
      selectedCountry = countryList.firstWhere((element) => element.isSelected);
      //selectedCountry = countryList.elementAt(index);
      _searchCountryResponse.safeAdd(Resource.success(data: countryList));
    }
  }

  void searchCountry(String? searchText) {
    searchResult!.clear();
    List<CountryData>? countryList = _getCountryListResponse.value.data!.content!.countryData;
    if (searchText!.isNotEmpty) {
      for (int i = 0; i < countryList!.length; i++) {
        CountryData country = countryList[i];
        if (country.countryName!.toLowerCase().contains(searchText.toLowerCase())) {
          searchResult!.add(country);
        }
      }
      _searchCountryResponse.safeAdd(Resource.success(data: searchResult));
      scrollController = FixedExtentScrollController(initialItem: 0);
      selectCountry(0);
    } else {
      _searchCountryResponse
          .safeAdd(Resource.success(data: _getCountryListResponse.value.data!.content!.countryData));
      scrollController = FixedExtentScrollController(
          initialItem:
              _getCountryListResponse.value.data!.content!.countryData!.indexOf(initialSelectedCountry!));
      selectCountry(
          _getCountryListResponse.value.data!.content!.countryData!.indexOf(initialSelectedCountry!));
    }
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    _searchCountryResponse.close();
    _getCountryListRequest.close();
    _getCountryListResponse.close();
    super.dispose();
  }
}
