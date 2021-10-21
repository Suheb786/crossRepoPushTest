import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/constants/enum/nature_of_special_needs_enum.dart';

class EmploymentStatusDialogViewModel extends BasePageViewModel {
  List<String> employmentStatusList = [
    "Retired",
    "Student",
    "Unemployed",
    "Other"
  ];
  List<String> sensoryEmploymentStatusList = [
    "Business Owner",
    "Full-Time Employee",
    "Part-Time Employee",
    "Freelance"
  ];

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  List<String> getStatusList(NatureOfSpecialNeedsEnum typeEnum) {
    switch (typeEnum) {
      case NatureOfSpecialNeedsEnum.SENSORY:
        return sensoryEmploymentStatusList;
      default:
        return employmentStatusList;
    }
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    super.dispose();
  }
}
