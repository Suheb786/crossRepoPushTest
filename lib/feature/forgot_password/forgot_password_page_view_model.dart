import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordPageViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();

  ///current page index request holder
  PublishSubject<int> _currentPageSubject = PublishSubject();

  ///current page index stream
  Stream<int> get currentPageStream => _currentPageSubject.stream;

  PageController appSwiperController = PageController(viewportFraction: 0.90);

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

  @override
  void dispose() {
    _currentPageSubject.close();
    super.dispose();
  }
}
