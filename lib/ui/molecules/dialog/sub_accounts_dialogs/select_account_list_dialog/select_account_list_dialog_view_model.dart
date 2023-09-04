import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../base/base_page_view_model.dart';

class SelectAccountListDialogPageViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }
}
