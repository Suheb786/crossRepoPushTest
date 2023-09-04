import 'package:rxdart/rxdart.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../base/base_page_view_model.dart';

class RJBookingConfirmedInAppWebViewPageViewModel extends BasePageViewModel {
  InAppWebViewController? webViewController;

  /// indicator progress value subject holder
  PublishSubject<double> _indicatorProgressSubject = PublishSubject();

  /// indicator progress value stream
  Stream<double> get indicatorProgressStream => _indicatorProgressSubject.stream;

  ///indicator progress value set function
  void setIndicatorProgressValue(double progress) {
    _indicatorProgressSubject.add(progress);
  }
}
