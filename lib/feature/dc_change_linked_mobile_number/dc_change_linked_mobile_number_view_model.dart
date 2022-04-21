import 'package:card_swiper/card_swiper.dart';
import 'package:domain/usecase/manage_contacts/get_beneficiary_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class DcChangeLinkedMobileNumberViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();
  PageController appSwiperController = PageController(viewportFraction: 0.8);
  PageController controller =
      PageController(viewportFraction: 0.8, keepPage: true, initialPage: 0);
  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  PublishSubject<PageController> _pageControllerSubject = PublishSubject();

  Stream<PageController> get pageControllerStream =>
      _pageControllerSubject.stream;

  PublishSubject<GetBeneficiaryUseCaseParams> _getBeneficiaryRequest =
      PublishSubject();

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void nextPage() {
    appSwiperController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void updatePageControllerStream(int index) {
    controller = PageController(
        initialPage: index, viewportFraction: 0.8, keepPage: true);
    _pageControllerSubject.safeAdd(controller);
  }

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}
