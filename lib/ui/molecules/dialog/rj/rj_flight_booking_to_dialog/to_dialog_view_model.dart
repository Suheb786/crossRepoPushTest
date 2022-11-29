import 'package:domain/model/rj/destinations.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class ToDialogViewModel extends BasePageViewModel {
  final TextEditingController countrySearchController = TextEditingController();

  FixedExtentScrollController scrollController = FixedExtentScrollController();

  List<Destinations> allCountryList = [];

  Stream<Resource<List<Destinations>>> get toSearchCountryStream => _toSearchCountrySubject.stream;

  ///search country response holder
  BehaviorSubject<Resource<List<Destinations>>> _toSearchCountrySubject = BehaviorSubject();
  List<Destinations> searchCountryList = [];

  void typeSearchCountry(String? searchText) {
    searchCountryList.clear();
    if (searchText!.isNotEmpty) {
      allCountryList.forEach((element) {
        if ((element.airportName ?? '').toLowerCase().contains(searchText) ||
            (element.countryName ?? '').toLowerCase().contains(searchText) ||
            (element.name ?? '').toLowerCase().contains(searchText) ||
            (element.cityName ?? '').toLowerCase().contains(searchText)) {
          searchCountryList.add(element);
        }
      });

      _toSearchCountrySubject.safeAdd(Resource.success(data: searchCountryList));
      selectCountry(0);
    } else {
      _toSearchCountrySubject.safeAdd(Resource.success(data: allCountryList));
      selectCountry(0);
    }
  }

  Destinations selectedDestination = Destinations();

  void selectCountry(int index) {
    List<Destinations>? countryList = _toSearchCountrySubject.value.data;
    if (countryList!.isNotEmpty) {
      countryList.forEach((element) {
        element.isSelected = false;
      });
      countryList.elementAt(index).isSelected = true;
      selectedDestination = countryList.firstWhere((element) => element.isSelected);
      _toSearchCountrySubject.safeAdd(Resource.success(data: countryList));
    }
  }

  void addSearchList(List<Destinations> destinationList) {
    allCountryList = destinationList;
  }

  @override
  void dispose() {
    _toSearchCountrySubject.close();
    super.dispose();
  }
}
