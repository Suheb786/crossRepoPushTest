import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class AppHomeViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();
  PageController controller =
      PageController(viewportFraction: 0.8, keepPage: true, initialPage: 1);
  TextEditingController exampleController = TextEditingController();
  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  PublishSubject<PageController> _pageControllerSubject = PublishSubject();

  PublishSubject<bool> _showTimeLineSubject = PublishSubject();

  Stream<bool> get showTimeLineStream => _showTimeLineSubject.stream;

  Stream<PageController> get pageControllerStream =>
      _pageControllerSubject.stream;

  PublishSubject<TextEditingController> _exampleControllerSubject =
      PublishSubject();

  Stream<TextEditingController> get exampleControllerStream =>
      _exampleControllerSubject.stream;

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void updatePageControllerStream(int index) {
    controller = PageController(
        initialPage: index, viewportFraction: 0.8, keepPage: true);
    _pageControllerSubject.safeAdd(controller);
  }

  void updateExampleControllerStream(String index) {
    exampleController.text = index;
    _exampleControllerSubject.safeAdd(exampleController);
  }

  void updateShowTimeLineStream(bool value) {
    _showTimeLineSubject.add(value);
  }

  @override
  void dispose() {
    _currentStep.close();
    _pageControllerSubject.close();
    super.dispose();
  }
}
