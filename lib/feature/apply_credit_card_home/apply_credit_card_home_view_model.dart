import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class ApplyCreditCardHomeViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  PageController appSwiperController = PageController(viewportFraction: 0.90);

  ApplyCreditCardHomeViewModel();

  void nextPage() {
    appSwiperController.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}
