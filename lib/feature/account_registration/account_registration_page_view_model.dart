import 'package:card_swiper/card_swiper.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class AccountRegistrationPageViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();

  PageController appSwiperController = PageController(viewportFraction: 0.8);

  ///current page index request holder
  PublishSubject<int> _currentPageSubject = PublishSubject();

  PublishSubject<bool> _swipeEnableSubject = PublishSubject();

  ///current page index stream
  Stream<int> get currentPageStream => _currentPageSubject.stream;
  Stream<bool> get swipeEnableStream => _swipeEnableSubject.stream;

  void nextPage() {
    appSwiperController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void changeCurrentPage(int index) {
    _currentPageSubject.safeAdd(index);
    toggleSwipeEnable(false);
  }

  void toggleSwipeEnable(bool value) {
    _swipeEnableSubject.safeAdd(value);
  }

  void navigateToPage(int index) {
    if (index != null) pageController.move(index, animation: false);
  }

  ///mobile number request holder
  BehaviorSubject<MobileNumberParams> _mobileNumberSubject = BehaviorSubject();

  ///mobile number stream
  Stream<MobileNumberParams> get mobileNumberStream =>
      _mobileNumberSubject.stream;

  void updateMobileNumber(MobileNumberParams mobileNumberParams) {
    _mobileNumberSubject.safeAdd(mobileNumberParams);
  }

  List<CountryData> countryDataList = [];

  @override
  void dispose() {
    _currentPageSubject.close();
    super.dispose();
  }
}

class MobileNumberParams {
  final String mobileNumber;
  final String mobileCode;

  MobileNumberParams({this.mobileNumber: "", this.mobileCode: ""});
}
