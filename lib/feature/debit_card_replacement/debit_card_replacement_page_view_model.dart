import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class DebitCardReplacementPageViewModel extends BasePageViewModel {
  final SwiperController swiperController = SwiperController();

  ///current page index request holder
  PublishSubject<int> _currentPageSubject = PublishSubject();

  ///current page index stream
  Stream<int> get currentPageStream => _currentPageSubject.stream;

  PageController appSwiperController = PageController(viewportFraction: 0.90);

  void navigateToPage(int index) {
    if (index != null) swiperController.move(index, animation: false);
  }

  void nextPage() {
    appSwiperController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void changeCurrentPage(int index) {
    _currentPageSubject.safeAdd(index);
  }

  void moveToPage(int index) {
    appSwiperController.jumpToPage(
      index,
    );
  }

  DebitCardReplacementArguments debitCardReplacementArguments =
      DebitCardReplacementArguments();

  @override
  void dispose() {
    _currentPageSubject.close();
    super.dispose();
  }
}
