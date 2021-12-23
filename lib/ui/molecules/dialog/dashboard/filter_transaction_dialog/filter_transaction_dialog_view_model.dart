import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class FilterTransactionDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController =
  FixedExtentScrollController();

  List<String> filterTransactionList = [
    "Last 30 days",
    "Last 3 months",
    "Last 6 months"
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
