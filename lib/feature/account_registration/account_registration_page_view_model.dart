import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class AccountRegistrationPageViewModel extends BasePageViewModel {
  final CarouselController pageController = CarouselController();

  PageController accountRegistrationStepsController = PageController();

  ///current page index request holder
  PublishSubject<int> _currentPageSubject = PublishSubject();

  ///current page index stream
  Stream<int> get currentPageStream => _currentPageSubject.stream;

  void changeCurrentPage(int index) {
    _currentPageSubject.safeAdd(index);
  }

  @override
  void dispose() {
    _currentPageSubject.close();
    super.dispose();
  }
}
