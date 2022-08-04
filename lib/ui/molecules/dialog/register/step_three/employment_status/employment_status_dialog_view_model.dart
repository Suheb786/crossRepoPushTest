import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class EmploymentStatusDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();

  List<String> employmentStatusList = [
    "Business Owner",
    "Full-Time Employee",
    "Part-Time Employee",
    "Freelance",
    "Retired",
    "Student",
    "Unemployed", "Housewife",
    //"Other"
  ];
  List<String> employmentStatusListAr = [
    "احب عمل",
    "وظف بدوام كامل,",
    "موظف دوام جزئي",
    "اعمال حرة",
    "متقاعد",
    "طالب",
    "عاطل عن العم", "ربة منزل"
    //"Other"
  ];

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    super.dispose();
  }
}
