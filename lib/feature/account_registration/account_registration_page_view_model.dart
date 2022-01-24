import 'package:card_swiper/card_swiper.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class AccountRegistrationPageViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();

  // PageController accountRegistrationStepsController = PageController();

  ///current page index request holder
  PublishSubject<int> _currentPageSubject = PublishSubject();

  ///current page index stream
  Stream<int> get currentPageStream => _currentPageSubject.stream;

  void changeCurrentPage(int index) {
    _currentPageSubject.safeAdd(index);
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
