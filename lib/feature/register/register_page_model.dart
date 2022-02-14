import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class RegisterViewModel extends BasePageViewModel {
  PageController registrationStepsController = PageController();

  PublishSubject<int> _currentPageSubject = PublishSubject();

  Stream<int> get currentPageSubject => _currentPageSubject.stream;

  RegisterViewModel() {
    changeCurrentPage(registrationStepsController.initialPage);
  }

  void changeCurrentPage(int currentPage) {
    _currentPageSubject.safeAdd(currentPage);
  }

  void goToPreviousPage() {
    registrationStepsController.animateToPage(
        registrationStepsController.page!.toInt() - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn);
  }

  void goToNextPage() {
    registrationStepsController.animateToPage(
        registrationStepsController.page!.toInt() + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn);
  }

  void navigateToPage(int index) {
    print('navigate');
    registrationStepsController.jumpToPage(
      index,
    );
    // if (index != registrationStepsController.page!.toInt())
    //   registrationStepsController.animateToPage(index,
    //       duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _currentPageSubject.close();
    super.dispose();
  }
}
