import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class ToDialogViewModel extends BasePageViewModel {
  final TextEditingController countrySearchController = TextEditingController();

  FixedExtentScrollController scrollController = FixedExtentScrollController();

  ///current selected index subject holder
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.safeAdd(index);
  }

  Stream<Resource<List<ToSearchCountry>>> get toSearchCountryStream => _toSearchCountrySubject.stream;

  ///search country response holder
  PublishSubject<Resource<List<ToSearchCountry>>> _toSearchCountrySubject = PublishSubject();
  List<ToSearchCountry> searchCountryList = [];

  void typeSearchCountry(String? searchText) {
    searchCountryList.clear();
    if (searchText!.isNotEmpty) {
      toSearchCountryList.forEach((element) {
        if (element.searchCountry.toLowerCase().contains(searchText)) {
          searchCountryList.add(element);
        }
      });

      _toSearchCountrySubject.safeAdd(Resource.success(data: searchCountryList));
    } else {
      _toSearchCountrySubject.safeAdd(Resource.success(data: searchCountryList));
    }
  }

  @override
  void dispose() {
    _currentSelectIndex.close();

    _toSearchCountrySubject.close();
    super.dispose();
  }

  List<ToSearchCountry> toSearchCountryList = [
    ToSearchCountry('NRT - Tokyo Narita Intl.'),
    ToSearchCountry('KIX - Osaka Kansai Intl.'),
    ToSearchCountry('CTS - Sapporo New Chitose'),
    ToSearchCountry('FUK - Fukuoka'),
  ];
}

class ToSearchCountry {
  final String searchCountry;
  ToSearchCountry(this.searchCountry);
}
