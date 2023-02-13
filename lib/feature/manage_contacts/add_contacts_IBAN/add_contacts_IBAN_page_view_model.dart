import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class AddContactsIBANManageContactsPageViewModel extends BasePageViewModel {
  PageController appSwiperController = PageController(viewportFraction: 0.90);
  PublishSubject<int> _currentStep = PublishSubject();
  PublishSubject<int> _currentPageSubject = PublishSubject();

  ///current page index stream
  Stream<int> get currentPageStream => _currentPageSubject.stream;
  final SwiperController pageController = SwiperController();

  Stream<int> get currentStep => _currentStep.stream;
  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void nextPage() {
    appSwiperController.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void changeCurrentPage(int index) {
    _currentPageSubject.safeAdd(index);
  }
}
