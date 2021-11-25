import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class AppHomeViewModel extends BasePageViewModel {
  PageController appHomeController = PageController();

  PublishSubject<int> _currentPageSubject = PublishSubject();

  Stream<int> get currentPageSubject => _currentPageSubject.stream;

  RegisterViewModel() {
    changeCurrentPage(appHomeController.initialPage);
  }

  void changeCurrentPage(int currentPage) {
    _currentPageSubject.safeAdd(currentPage);
  }

  void goToPreviousPage() {
    appHomeController.animateToPage(appHomeController.page!.toInt() - 1,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void goToNextPage() {
    appHomeController.animateToPage(appHomeController.page!.toInt() + 1,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _currentPageSubject.close();
    super.dispose();
  }
}
