import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class SendMoneyQRScanningPageViewModel extends BasePageViewModel {
  SendMoneyQRScanningArguments? arguments;

  final SwiperController swiperController = SwiperController();

  ///-----------------------current page ------------------------///
  PublishSubject<int> _currentPageSubject = PublishSubject();

  Stream<int> get currentPageStream => _currentPageSubject.stream;

  void changeCurrentPage(int index) {
    _currentPageSubject.safeAdd(index);
  }

  ///-----------------------current page ------------------------///

  PageController appSwiperController = PageController(viewportFraction: 0.90);

  void nextPage() {
    appSwiperController.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  void dispose() {
    _currentPageSubject.close();
    super.dispose();
  }
}
