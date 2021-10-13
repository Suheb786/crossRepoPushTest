import 'package:domain/model/country/country.dart';
import 'package:domain/usecase/user/fetch_countries_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class EmployerCountryDialogViewModel extends BasePageViewModel {
  final FetchCountriesUseCase _fetchCountriesUseCase;

  Country? selectedCountry = Country();
  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  PublishSubject<FetchCountriesUseParams> _getEmployerCountryRequest =
      PublishSubject();

  BehaviorSubject<Resource<List<Country>>> _getEmployerCountryResponse =
      BehaviorSubject();

  Stream<Resource<List<Country>>> get getEmployerCountryStream =>
      _getEmployerCountryResponse.stream;

  EmployerCountryDialogViewModel(this._fetchCountriesUseCase) {
    _getEmployerCountryRequest.listen((value) {
      RequestManager(value,
              createCall: () => _fetchCountriesUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getEmployerCountryResponse.safeAdd(event);
      });
    });
  }

  void getEmployerCountryList(BuildContext context) {
    _getEmployerCountryRequest
        .safeAdd(FetchCountriesUseParams(context: context));
  }

  void selectCountry(int index) {
    List<Country>? countryList = _getEmployerCountryResponse.value.data;
    countryList?.forEach((element) {
      element.isSelected = false;
    });
    countryList?.elementAt(index).isSelected = true;
    selectedCountry = countryList?.firstWhere((element) => element.isSelected);
    _getEmployerCountryResponse.safeAdd(Resource.success(data: countryList));
  }
}
