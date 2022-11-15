import 'package:card_swiper/card_swiper.dart';
import 'package:domain/constants/enum/tax_payer_type.dart';
import 'package:domain/model/fatca_crs/fatca_w8_data.dart';
import 'package:domain/model/fatca_crs/fatca_w9_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class RegisterStepFourViewModel extends BasePageViewModel {
  final SwiperController registrationStepFourPageController = SwiperController();

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  bool isGetFatca = false;

  TaxPayerTypeEnum _taxPayerTypeEnum = TaxPayerTypeEnum.NONE;

  TaxPayerTypeEnum get taxPayerType => _taxPayerTypeEnum;

  PageController appSwiperController = PageController(viewportFraction: 0.90);

  void nextPage() {
    appSwiperController.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void moveToPage(int index) {
    appSwiperController.jumpToPage(
      index,
    );
  }

  void previousPage() {
    appSwiperController.previousPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void setTaxPayerTypeEnum(TaxPayerTypeEnum taxPayerTypeEnum) {
    _taxPayerTypeEnum = taxPayerTypeEnum;
  }

  ///set fatca w8 data

  FatcaW8Data _fatcaW8Data = FatcaW8Data();

  FatcaW8Data get getFatcaW8Data => _fatcaW8Data;

  void setFatcaW8(FatcaW8Data data) {
    _fatcaW8Data = data;
  }

  ///set fatca w9 data
  FatcaW9Data _fatcaW9Data = FatcaW9Data();

  FatcaW9Data get getFatcaW9Data => _fatcaW9Data;

  void setFatcaW9(FatcaW9Data data) {
    _fatcaW9Data = data;
  }

  void updateFatcaToInitial() {
    _fatcaW8Data = FatcaW8Data();
    _fatcaW9Data = FatcaW9Data();
  }

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}
