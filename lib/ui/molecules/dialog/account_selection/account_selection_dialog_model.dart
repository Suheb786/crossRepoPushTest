import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class AccountSelectionDialogModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;
  List<Account> allCategories = [];

  AccountSelectionDialogModel();

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }
}
