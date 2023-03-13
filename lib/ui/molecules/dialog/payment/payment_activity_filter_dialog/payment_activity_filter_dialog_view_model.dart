import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/payment_activity_filter_dialog/payment_activity_filter_dialog.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';

class PaymentActivityFilterDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();

  List<String>? transactionTypeListEn = ["All Transactions", "From Me", "From Others"];

  List<String>? transactionTypeListAr = ["كل الحركات", "لي", "من الآخرين"];

  List<String>? transactionPeriodList = ["Last 30 days", "Last 3 months", "Last 6 months"];

  List<String> transactionPeriodListAr = ["آخر 30 يوم", "آخر 3 اشهر", "آخر 6 اشهر"];

  List<String>? getTransactionList(FilterType type, BuildContext context) {
    switch (type) {
      case FilterType.type:
        return StringUtils.isDirectionRTL(context) ? transactionTypeListAr : transactionTypeListEn;

      case FilterType.period:
        return StringUtils.isDirectionRTL(context) ? transactionPeriodListAr : transactionPeriodList;
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
