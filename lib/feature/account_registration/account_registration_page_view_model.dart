import 'package:card_swiper/card_swiper.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class AccountRegistrationPageViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();

  PageController appSwiperController = PageController(viewportFraction: 0.90);

  ///current page index request holder
  PublishSubject<int> _currentPageSubject = PublishSubject();

  ///current page index stream
  Stream<int> get currentPageStream => _currentPageSubject.stream;

  void nextPage() {
    appSwiperController.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void changeCurrentPage(int index) {
    _currentPageSubject.safeAdd(index);
  }

  void navigateToPage(int index) {
    pageController.move(index, animation: false);
  }

  void moveToPage(int index) {
    appSwiperController.jumpToPage(
      index,
    );
  }

  ///mobile number request holder
  BehaviorSubject<MobileNumberParams> _mobileNumberSubject = BehaviorSubject();

  ///mobile number stream
  Stream<MobileNumberParams> get mobileNumberStream => _mobileNumberSubject.stream;

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

  MobileNumberParams({this.mobileNumber = "", this.mobileCode = ""});
}
