import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/payment/payment_to_new_recipient/payment_to_new_recipient_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class PaymentToNewRecipientViewModel extends BasePageViewModel {
  PaymentToNewRecipentPageArgument? argument;

  final SwiperController pageController = SwiperController();

  PublishSubject<int> _currentStep = PublishSubject();

  TextEditingController editAmountController = TextEditingController();

  PublishSubject<bool> _editAmountSubject = PublishSubject();

  Stream<bool> get editAmountStream => _editAmountSubject.stream;

  Stream<int> get currentStep => _currentStep.stream;

  PageController appSwiperController = PageController(viewportFraction: 0.90);

  void nextPage() {
    appSwiperController.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void updateEditAmount(bool value) {
    _editAmountSubject.safeAdd(value);
  }

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}
