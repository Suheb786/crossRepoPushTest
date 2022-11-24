import 'package:domain/model/purpose/purpose.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class PurposeDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();

  List<Purpose>? purposeList = [];

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  PurposeDialogViewModel(this.purposeList);

  @override
  void dispose() {
    _currentSelectIndex.close();
    super.dispose();
  }
}
