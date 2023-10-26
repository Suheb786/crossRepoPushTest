import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/qr_scan_otp/qr_scan_otp_page_view.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/qr_scan_otp/qr_scan_otp_page_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class QRScanOTPPage extends BasePage<QRScanOTPPageViewModel> {
  @override
  QRScanOTPPageState createState() => QRScanOTPPageState();
}

class QRScanOTPPageState extends BaseStatefulPage<QRScanOTPPageViewModel, QRScanOTPPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  QRScanOTPPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return qrScanOTPViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(QRScanOTPPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, QRScanOTPPageViewModel model) {
    return QRScanOTPPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void codeUpdated() {
    getViewModel().otpController.text = code ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Future<bool> onBackPressed(QRScanOTPPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(sendMoneyQrScanningViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
