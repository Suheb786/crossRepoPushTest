import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';

import '../../../di/app/app_modules.dart';
import '../../../generated/l10n.dart';

class RjBookingPageViewModel extends BasePageViewModel {
  RjBookingPageArguments? rjBookingPageArguments;
  InAppWebViewController? webViewController;

  String? confirmationUrl;

  BehaviorSubject<bool> _navigationToFlightBookingDetailSubject = BehaviorSubject.seeded(false);

  Stream<bool> get navigationToFlightBookingDetailStream => _navigationToFlightBookingDetailSubject.stream;

  RjBookingPageViewModel() {
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

  void shareFiles(BuildContext context, String url) async {
    await Share.share(
      url,
      subject: S.of(context).confirmationURL,
    );
  }

  setConfirmationView() {
    _navigationToFlightBookingDetailSubject.safeAdd(true);
  }

  setPurchaseTicketView() {
    _navigationToFlightBookingDetailSubject.safeAdd(false);
  }

  bool isNavigationOnConfirmationView() {
    return _navigationToFlightBookingDetailSubject.value;
  }

  @override
  void dispose() {
    _navigationToFlightBookingDetailSubject.close();
    _indicatorProgressSubject.close();
    super.dispose();
  }
}
