import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher_without_region/purchase_evoucher_without_region_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/base_page_view_model.dart';

class PurchaseEVoucherWithoutRegionPageViewModel extends BasePageViewModel {
  late PurchaseEVoucherWithoutRegionPageArgument argument;

  PurchaseEVoucherWithoutRegionPageViewModel();

  final SwiperController pageController = SwiperController();

  PageController appSwiperController = PageController(viewportFraction: 0.90);

  ///current page index request holder
  PublishSubject<int> _currentPageSubject = PublishSubject();

  ///current page index stream
  Stream<int> get currentPageStream => _currentPageSubject.stream;

  void nextPage() {
    appSwiperController.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void changeCurrentPage(int index) {
    _currentPageSubject.safeAdd(index);
  }

  void navigateToPage(int index) {
    pageController.move(index, animation: false);
  }

  void moveToPage(int index) {
    appSwiperController.jumpToPage(
      index,
    );
  }

  @override
  void dispose() {
    _currentPageSubject.close();
    super.dispose();
  }
}
