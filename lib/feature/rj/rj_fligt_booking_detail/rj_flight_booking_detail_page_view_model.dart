import 'package:card_swiper/card_swiper.dart';
import 'package:domain/model/rj/get_flight_detail/flight_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_fligt_booking_page.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_make_payment/rj_make_payment_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class RjFlightBookingDetailPageViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();

  late RJFlightDetailsPageArguments? arguments;
  MakePaymentCard? selectedCard;

  FlightDetailResponse flightDetailResponse = FlightDetailResponse();

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

  @override
  void dispose() {
    _currentPageSubject.close();
    super.dispose();
  }
}
