import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/add_beneficiary/add_beneficiary_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class AddBeneficiaryPageViewModel extends BasePageViewModel {
  ///--------------------------controllers-------------------------------------///

  PageController appSwiperController = PageController(viewportFraction: 0.90);
  final SwiperController pageController = SwiperController();

  ///--------------------------current-page-subject-------------------------------------///

  PublishSubject<int> _currentPageSubject = PublishSubject();

  Stream<int> get currentPageStream => _currentPageSubject.stream;

  ///--------------------------current-step-subject-------------------------------------///

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  ///--------------------------public-other-methods-------------------------------------///

  late AddBeneficiaryPageArguments arguments;

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

  @override
  void dispose() {
    _currentPageSubject.close();
    super.dispose();
  }
}
