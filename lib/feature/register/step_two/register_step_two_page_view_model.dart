import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class RegisterStepTwoViewModel extends BasePageViewModel {
  final SwiperController registrationStepTwoPageController =
      new SwiperController();

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  BehaviorSubject<List<Widget>> _pages = BehaviorSubject.seeded([Container()]);

  Stream<List<Widget>> get pagesStream => _pages.stream;

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void updatePages(List<Widget> pages) {
    _pages.value.clear();
    _pages.safeAdd(pages);
  }

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}
