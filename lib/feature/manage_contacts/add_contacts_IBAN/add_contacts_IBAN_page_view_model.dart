import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class AddContactsIBANManageContactsPageViewModel extends BasePageViewModel {
  PageController appSwiperController = PageController(viewportFraction: 0.90);
  PublishSubject<int> _currentStep = PublishSubject();
  final SwiperController pageController = SwiperController();

  Stream<int> get currentStep => _currentStep.stream;
  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }
}
