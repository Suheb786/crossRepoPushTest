import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class PayBillDialogViewModel extends BasePageViewModel {
  final TextEditingController searchBillNameController = TextEditingController();

  FixedExtentScrollController scrollController = FixedExtentScrollController();

  ///current selected index subject holder
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.safeAdd(index);
  }

  PublishSubject<List<String>> _searchBillNameSubject = PublishSubject();

  Stream<List<String>> get searchBillNameStream => _searchBillNameSubject.stream;

  List<String> searchList = [];
  List<String> billNameList = [];

  void searchBillName(String searchText) {
    searchList.clear();
    if (searchText.isNotEmpty) {
      billNameList.forEach((element) {
        if (element.toLowerCase().contains(searchText)) {
          searchList.add(element);
        }
      });

      _searchBillNameSubject.safeAdd(searchList);
    } else {
      _searchBillNameSubject.safeAdd(searchList);
    }
  }

  @override
  void dispose() {
    _currentSelectIndex.close();

    _searchBillNameSubject.close();
    super.dispose();
  }
}
