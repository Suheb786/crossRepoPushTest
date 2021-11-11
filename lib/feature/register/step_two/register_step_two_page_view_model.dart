import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class RegisterStepTwoViewModel extends BasePageViewModel {
  final CarouselController registrationStepTwoPageController =
      new CarouselController();

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  List<Widget> pages = [];

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}
