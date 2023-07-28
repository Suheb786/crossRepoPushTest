import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:rxdart/rxdart.dart';

class RegionFilterDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;
  List<VoucherRegionByCategories> allRegion = [VoucherRegionByCategories(countryName: S.current.allRegion)];

  RegionFilterDialogViewModel();

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }
}
