import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class SettingsDialogViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();

  final CarouselController controller = CarouselController();

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }
}
