import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class PurposeDetailDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController();

  List<PurposeDetail>? purposeDetailList = [];

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  PurposeDetailDialogViewModel(this.purposeDetailList);

  @override
  void dispose() {
    _currentSelectIndex.close();
    super.dispose();
  }
}
