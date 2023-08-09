import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesFilterDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;
  List<VoucherCategories> allCategories = [VoucherCategories(id: 0, categoryName: S.current.allCategories)];

  CategoriesFilterDialogViewModel();

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }
}
