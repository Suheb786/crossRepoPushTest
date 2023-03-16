import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_otp_screen/reject_request_payment_otp_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_otp_screen/reject_request_payment_page_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RejectRequestPaymentOtpPage extends BasePage<RejectRequestPaymentOtpPageViewModel> {
  @override
  RejectRequestPaymentOtpPageState createState() => RejectRequestPaymentOtpPageState();
}

class RejectRequestPaymentOtpPageState
    extends BaseStatefulPage<RejectRequestPaymentOtpPageViewModel, RejectRequestPaymentOtpPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  RejectRequestPaymentOtpPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return rejectRequestPaymentOtpPageViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(RejectRequestPaymentOtpPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, RejectRequestPaymentOtpPageViewModel model) {
    return RejectRequestPaymentOtpPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      print('inside signature---->$signature');
    });
  }

  @override
  void codeUpdated() {
    getViewModel().otpController.text = code!;
  }

  @override
  void dispose() {
    print('inside dispose');
    super.dispose();
    cancel();
  }
}
