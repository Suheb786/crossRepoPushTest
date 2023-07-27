import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesFilterDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;
  List<VoucherCategories> allCategories = [
    ///TODO Generate this String for arb file
    VoucherCategories(id: 0, categoryName: "All Categories")
  ];

  CategoriesFilterDialogViewModel();

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }
}
