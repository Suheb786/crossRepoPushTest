import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class RejectRequestPaymentPageViewModel extends BasePageViewModel {
  RejectRequestPaymentPageArgument argument = RejectRequestPaymentPageArgument(
      amount: '', name: '', iban: '', statusInfo: '', custID: '', OrgnlMsgId: '', rtpStatus: '');

  RejectRequestPaymentPageViewModel();

  final SwiperController pageController = SwiperController();

  ///current page index request holder
  PublishSubject<int> _currentPageSubject = PublishSubject();

  ///current page index stream
  Stream<int> get currentPageStream => _currentPageSubject.stream;

  PageController appSwiperController = PageController(viewportFraction: 0.90);

  BehaviorSubject<String> _changeHeaderWhileEnteringText = BehaviorSubject();

  Stream<String> get changeHeaderWhileEnteringText => _changeHeaderWhileEnteringText.stream;

  void changeHeader(String value) {
    _changeHeaderWhileEnteringText.safeAdd(value);
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
