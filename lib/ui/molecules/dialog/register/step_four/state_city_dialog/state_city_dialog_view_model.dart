import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog.dart';
import 'package:rxdart/rxdart.dart';

class StateCityDialogViewModel extends BasePageViewModel {
  List<String> stateList = [
    'Alberta',
    'British Columbia',
    'Manitoba',
    'Newfoundland and Labrador',
    'Northwest Territories'
  ];
  List<String> cityList = [
    'Barrie',
    'Belleville',
    'Brampton',
    'Brantford',
    'Brockville'
  ];

  final TextEditingController controller = TextEditingController();

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  List<String> getList(StateCityTypeEnum typeEnum) {
    switch (typeEnum) {
      case StateCityTypeEnum.STATE:
        return stateList;
      case StateCityTypeEnum.CITY:
        return cityList;
      default:
        return stateList;
    }
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    super.dispose();
  }
}
