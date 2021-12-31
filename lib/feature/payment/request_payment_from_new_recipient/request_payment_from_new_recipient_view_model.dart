import 'package:card_swiper/card_swiper.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class RequestPaymentFromNewRecipientViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  String? sendValue;

  RequestPaymentFromNewRecipientViewModel(this.sendValue);

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}
