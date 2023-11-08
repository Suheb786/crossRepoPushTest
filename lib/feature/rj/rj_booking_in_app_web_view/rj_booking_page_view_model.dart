import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../di/app/app_modules.dart';

class RjBookingPageViewModel extends BasePageViewModel {
  final RjBookingPageArguments rjBookingPageArguments;
  InAppWebViewController? webViewController;

  RjBookingPageViewModel(this.rjBookingPageArguments) {
    ProviderScope.containerOf(appLevelKey.currentContext!).read(appViewModel).getToken();
  }

  /// indicator progress value subject holder
  PublishSubject<double> _indicatorProgressSubject = PublishSubject();

  /// indicator progress value stream
  Stream<double> get indicatorProgressStream => _indicatorProgressSubject.stream;

  ///indicator progress value set function
  void setIndicatorProgressValue(double progress) {
    _indicatorProgressSubject.add(progress);
  }
}
