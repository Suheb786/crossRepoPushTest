import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class LinkAccountDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();
  List<LinkBankAccountData> accountsList = [];

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

class LinkBankAccountData {
  final String accountType;
  final String accountNo;

  LinkBankAccountData(this.accountType, this.accountNo);
}
