import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/payment_activity_filter_dialog/payment_activity_filter_dialog.dart';
import 'package:rxdart/rxdart.dart';

class PaymentActivityFilterDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController();

  List<String>? transactionTypeList = [
    "All Transactions",
    "From Me",
    "From Others"
  ];

  List<String>? transactionPeriodList = [
    "Last 30 days",
    "Last 3 months",
    "Last 6 months"
  ];

  List<String>? getTransactionList(FilterType type) {
    switch (type) {
      case FilterType.type:
        return transactionTypeList;

      case FilterType.period:
        return transactionPeriodList;
    }
  }

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  PaymentActivityFilterDialogViewModel();

  @override
  void dispose() {
    _currentSelectIndex.close();
    super.dispose();
  }
}
