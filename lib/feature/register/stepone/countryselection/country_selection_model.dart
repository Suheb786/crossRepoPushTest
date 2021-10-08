import 'package:domain/model/country/country.dart';
import 'package:domain/usecase/user/fetch_countries_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class CountrySelectionViewModel extends BasePageViewModel {
  final FetchCountriesUseCase _fetchCountriesUseCase;
  PublishSubject<FetchCountriesUseParams> _fetchCountriesRequest =
      PublishSubject();

  BehaviorSubject<Resource<List<Country>>> _fetchCountriesResponse =
      BehaviorSubject();

  Stream<Resource<List<Country>>> get countries =>
      _fetchCountriesResponse.stream;

  Country? selectedCountry = Country();

  CountrySelectionViewModel(this._fetchCountriesUseCase) {
    _fetchCountriesRequest.listen((value) {
      RequestManager(value,
              createCall: () => _fetchCountriesUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _fetchCountriesResponse.safeAdd(event);
        selectCountry(0);
      });
    });
  }

  void fetchCountries(BuildContext context) {
    _fetchCountriesRequest.safeAdd(FetchCountriesUseParams(context: context));
  }

  void selectCountry(int index) {
    List<Country>? countryList = _fetchCountriesResponse.value.data;
    countryList?.forEach((element) {
      element.isSelected = false;
    });
    countryList?.elementAt(index).isSelected = true;
    selectedCountry = countryList?.firstWhere((element) => element.isSelected);
    _fetchCountriesResponse.safeAdd(Resource.success(data: countryList));
  }

  @override
  void dispose() {
    _fetchCountriesRequest.close();
    _fetchCountriesResponse.close();
    super.dispose();
  }
}
