import 'package:domain/model/country/country.dart';
import 'package:domain/model/country/country_list/country_list_content_data.dart';
import 'package:domain/usecase/country/fetch_countries_usecase.dart';
import 'package:domain/usecase/country/get_countries_list_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class CountryDialogViewModel extends BasePageViewModel {
  final FetchCountriesUseCase _fetchCountriesUseCase;

  final GetCountriesListUseCase _getCountriesListUseCase;

  final TextEditingController countrySearchController = TextEditingController();

  final FixedExtentScrollController scrollController =
      FixedExtentScrollController();

  Country? selectedCountry = Country();

  ///current selected index subject holder
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  List<Country>? searchResult = [];

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  ///get country request holder
  PublishSubject<FetchCountriesUseParams> _getCountryRequest = PublishSubject();

  ///get country response holder
  BehaviorSubject<Resource<List<Country>>> _getCountryResponse =
      BehaviorSubject();

  ///get country response stream
  Stream<Resource<List<Country>>> get getCountryStream =>
      _searchCountryResponse.stream;

  ///get country list request holder
  PublishSubject<GetCountriesListUseCaseParams> _getCountryListRequest =
      PublishSubject();

  ///get country list response holder
  BehaviorSubject<Resource<CountryListContentData>> _getCountryListResponse =
      BehaviorSubject();

  ///get country list response stream
  Stream<Resource<CountryListContentData>> get getCountryListStream =>
      _getCountryListResponse.stream;

  ///search country response holder
  BehaviorSubject<Resource<List<Country>>> _searchCountryResponse =
      BehaviorSubject();

  CountryDialogViewModel(
      this._fetchCountriesUseCase, this._getCountriesListUseCase) {
    _getCountryRequest.listen((value) {
      RequestManager(value,
              createCall: () => _fetchCountriesUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getCountryResponse.safeAdd(event);
        _searchCountryResponse.safeAdd(event);
        selectCountry(0);
      });
    });

    _getCountryListRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getCountriesListUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getCountryListResponse.safeAdd(event);
      });
    });

    getCountries();
  }

  void getCountryList(BuildContext context) {
    _getCountryRequest.safeAdd(FetchCountriesUseParams(context: context));
  }

  void getCountries() {
    _getCountryListRequest.safeAdd(GetCountriesListUseCaseParams());
  }

  void selectCountry(int index) {
    List<Country>? countryList = _searchCountryResponse.value.data;
    countryList?.forEach((element) {
      element.isSelected = false;
    });
    countryList?.elementAt(index).isSelected = true;
    selectedCountry = countryList?.firstWhere((element) => element.isSelected);
    _searchCountryResponse.safeAdd(Resource.success(data: countryList));
  }

  void searchCountry(String? searchText) {
    searchResult!.clear();
    List<Country>? countryList = _getCountryResponse.value.data;
    if (searchText!.isNotEmpty) {
      for (int i = 0; i < countryList!.length; i++) {
        Country country = countryList[i];
        if (country.countryName!
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          searchResult!.add(country);
        }
      }
      _searchCountryResponse.safeAdd(Resource.success(data: searchResult));
      selectCountry(0);
    } else {
      _searchCountryResponse
          .safeAdd(Resource.success(data: _getCountryResponse.value.data));
    }
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    _getCountryRequest.close();
    _getCountryResponse.close();
    _searchCountryResponse.close();
    _getCountryListRequest.close();
    _getCountryListResponse.close();
    super.dispose();
  }
}
