import 'package:domain/model/country/state_list/state_city_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class StateCityDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();

  final TextEditingController controller = TextEditingController();

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  List<StateCityData> stateCityDataList = [];

  List<StateCityData>? searchResult = [];

  StateCityData selectedState = StateCityData();

  ///state city response holder
  BehaviorSubject<Resource<List<StateCityData>>> _stateCityResponse = BehaviorSubject();

  ///state city response stream
  Stream<Resource<List<StateCityData>>> get stateCityResponseStream => _stateCityResponse.stream;

  void selectCountry(int index) {
    List<StateCityData>? stateCityList = _stateCityResponse.value.data;
    if (stateCityList!.length > 0) {
      stateCityList.forEach((element) {
        element.isSelected = false;
      });
      stateCityList.elementAt(index).isSelected = true;
      selectedState = stateCityList.firstWhere((element) => element.isSelected);
      _stateCityResponse.safeAdd(Resource.success(data: stateCityList));
    }
  }

  void searchStateCity(String? searchText, StateCityTypeEnum stateCityTypeEnum) {
    searchResult!.clear();
    List<StateCityData>? stateCityList = stateCityDataList;
    if (searchText!.isNotEmpty) {
      for (int i = 0; i < stateCityList.length; i++) {
        StateCityData stateCityData = stateCityList[i];
        if (stateCityTypeEnum == StateCityTypeEnum.CITY) {
          if (stateCityData.cityName!.toLowerCase().contains(searchText.toLowerCase())) {
            searchResult!.add(stateCityData);
          }
        } else {
          if (stateCityData.stateName!.toLowerCase().contains(searchText.toLowerCase())) {
            searchResult!.add(stateCityData);
          }
        }
      }
      _stateCityResponse.safeAdd(Resource.success(data: searchResult));
      selectCountry(0);
    } else {
      _stateCityResponse.safeAdd(Resource.success(data: stateCityDataList));
    }
  }

  void setData(List<StateCityData> stateCityData) {
    stateCityDataList = stateCityData;
    _stateCityResponse.safeAdd(Resource.success(data: stateCityData));
    selectCountry(0);
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    super.dispose();
  }
}
