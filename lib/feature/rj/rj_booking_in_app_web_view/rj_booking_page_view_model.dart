import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page.dart';
import 'package:rxdart/rxdart.dart';

class RjBookingPageViewModel extends BasePageViewModel {
  final RjBookingPageArguments rjBookingPageArguments;
  InAppWebViewController? webViewController;

  RjBookingPageViewModel(this.rjBookingPageArguments);

  /// indicator progress value subject holder
  PublishSubject<double> _indicatorProgressSubject = PublishSubject();

  /// indicator progress value stream
  Stream<double> get indicatorProgressStream => _indicatorProgressSubject.stream;

  ///indicator progress value set function
  void setIndicatorProgressValue(double progress) {
    _indicatorProgressSubject.add(progress);
  }
}
