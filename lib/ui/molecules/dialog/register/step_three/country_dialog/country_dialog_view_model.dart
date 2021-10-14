import 'package:domain/model/country/country.dart';
import 'package:domain/usecase/user/fetch_countries_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class CountryDialogViewModel extends BasePageViewModel {
  final FetchCountriesUseCase _fetchCountriesUseCase;

  Country? selectedCountry = Country();

  ///current selected index subject holder
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

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
      _getCountryResponse.stream;

  CountryDialogViewModel(this._fetchCountriesUseCase) {
    _getCountryRequest.listen((value) {
      RequestManager(value,
              createCall: () => _fetchCountriesUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getCountryResponse.safeAdd(event);
      });
    });
  }

  void getCountryList(BuildContext context) {
    _getCountryRequest.safeAdd(FetchCountriesUseParams(context: context));
  }

  void selectCountry(int index) {
    List<Country>? countryList = _getCountryResponse.value.data;
    countryList?.forEach((element) {
      element.isSelected = false;
    });
    countryList?.elementAt(index).isSelected = true;
    selectedCountry = countryList?.firstWhere((element) => element.isSelected);
    _getCountryResponse.safeAdd(Resource.success(data: countryList));
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    _getCountryRequest.close();
    _getCountryResponse.close();
    super.dispose();
  }
}
