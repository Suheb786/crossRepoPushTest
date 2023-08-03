import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_otp/return_payment_otp_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_otp/return_payment_otp_page_view_model.dart';
import 'package:riverpod/src/framework.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ReturnPaymentOtpPage extends BasePage<ReturnPaymentOtpPageViewModel> {
  @override
  ReturnPaymentOtpPageState createState() => ReturnPaymentOtpPageState();
}

class ReturnPaymentOtpPageState extends BaseStatefulPage<ReturnPaymentOtpPageViewModel, ReturnPaymentOtpPage>
    with AutomaticKeepAliveClientMixin, CodeAutoFill {
  @override
  Widget buildView(BuildContext context, ReturnPaymentOtpPageViewModel model) {
    return ReturnPaymentOtpPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return returnPaymentOtpPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  void onModelReady(ReturnPaymentOtpPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
    super.onModelReady(model);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void codeUpdated() {
    getViewModel().otpController.text = code!;
  }

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  bool get wantKeepAlive => true;
}
