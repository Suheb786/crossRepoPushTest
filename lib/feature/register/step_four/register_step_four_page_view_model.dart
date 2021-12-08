import 'package:carousel_slider/carousel_controller.dart';
import 'package:domain/model/fatca_crs/fatca_set_data.dart';
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

  FatcaSetData _fatcaSetData = FatcaSetData();

  FatcaSetData get fatcaData => _fatcaSetData;

  void setFatcaData(FatcaSetData data) {
    _fatcaSetData = data;
  }

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}
