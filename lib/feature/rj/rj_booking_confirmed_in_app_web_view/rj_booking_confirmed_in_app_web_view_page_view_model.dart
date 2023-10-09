import 'package:neo_bank/feature/rj/rj_booking_confirmed_in_app_web_view/rj_booking_confirmed_in_app_web_view_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../base/base_page_view_model.dart';

class RJBookingConfirmedInAppWebViewPageViewModel extends BasePageViewModel {
  final RJBookingConfirmedInAppWebViewPageArguments arguments;

  InAppWebViewController? webViewController;

  /// indicator progress value subject holder
  PublishSubject<double> _indicatorProgressSubject = PublishSubject();

  RJBookingConfirmedInAppWebViewPageViewModel(this.arguments);

  /// indicator progress value stream
  Stream<double> get indicatorProgressStream => _indicatorProgressSubject.stream;

  ///indicator progress value set function
  void setIndicatorProgressValue(double progress) {
    _indicatorProgressSubject.add(progress);
  }
}
