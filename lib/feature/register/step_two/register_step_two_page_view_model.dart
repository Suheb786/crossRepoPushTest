import 'package:carousel_slider/carousel_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class RegisterStepTwoViewModel extends BasePageViewModel {
  final CarouselController registrationStepTwoPageController =
      new CarouselController();

  int _currentPage = 0;

  int get currentPage => _currentPage;

  set currentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}
