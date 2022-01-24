import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class RelationshipWithCardHolderDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController();

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  RelationshipWithCardHolderDialogViewModel();

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }
}
