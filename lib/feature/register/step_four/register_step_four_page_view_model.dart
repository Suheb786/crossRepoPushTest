import 'package:carousel_slider/carousel_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class RegisterStepFourViewModel extends BasePageViewModel {
  final CarouselController registrationStepFourPageController =
      CarouselController();

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}
