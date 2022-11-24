import 'package:domain/constants/enum/calendar_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/time_utils.dart';
import 'package:rxdart/rxdart.dart';

class YearMonthDialogViewModel extends BasePageViewModel {
  FixedExtentScrollController scrollController = FixedExtentScrollController();

  final TextEditingController yearController = TextEditingController();

  ///month list
  List<String> monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  ///year list
  List<String> yearList = List.generate(100, (index) => (DateTime.now().year - index).toString());

  ///time list
  List<String> timeList = [];

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  ///list response holder
  BehaviorSubject<Resource<List<String>>> _searchStringResponse = BehaviorSubject();

  ///List response stream
  Stream<Resource<List<String>>> get getListStream => _searchStringResponse.stream;

  List<String> searchResult = [];

  void searchYear(String? searchText) {
    searchResult.clear();
    List<String>? listOfYear = yearList;
    if (searchText!.isNotEmpty) {
      for (int i = 0; i < listOfYear.length; i++) {
        String year = listOfYear[i];
        if (year.contains(searchText)) {
          searchResult.add(year);
        }
      }
      _searchStringResponse.safeAdd(Resource.success(data: searchResult));
    } else {
      _searchStringResponse.safeAdd(Resource.success(data: yearList));
    }
  }

  void getList(CalendarEnum typeEnum) {
    switch (typeEnum) {
      case CalendarEnum.YEAR:
        _searchStringResponse.safeAdd(Resource.success(data: yearList));
        break;
      case CalendarEnum.TIME:
        _searchStringResponse.safeAdd(Resource.success(data: timeList));
        break;
      default:
        return _searchStringResponse.safeAdd(Resource.success(data: monthList));
    }
  }

  getTimeRange() {
    TimeUtils.getTimeRange().forEach((element) {
      timeList.add(element);
    });
  }

  YearMonthDialogViewModel() {
    getTimeRange();
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    _searchStringResponse.close();
    scrollController.dispose();
    super.dispose();
  }
}
