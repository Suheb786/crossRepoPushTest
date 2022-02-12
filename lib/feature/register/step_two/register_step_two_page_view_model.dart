import 'package:card_swiper/card_swiper.dart';
import 'package:domain/constants/enum/employment_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class RegisterStepTwoViewModel extends BasePageViewModel {
  final SwiperController registrationStepTwoPageController =
      new SwiperController();

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  PublishSubject<List<Widget>> _registrationStepTwoPage = PublishSubject();

  Stream<List<Widget>> get registrationStepTwoPage =>
      _registrationStepTwoPage.stream;

  PageController appSwiperController = PageController(viewportFraction: 0.90);

  void nextPage() {
    appSwiperController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void updatePages(List<Widget> pages) {
    _registrationStepTwoPage.safeAdd(pages);
  }

  EmploymentStatusEnum employmentStatusEnum = EmploymentStatusEnum.NONE;

  @override
  void dispose() {
    _currentStep.close();
    _registrationStepTwoPage.close();
    super.dispose();
  }
}
