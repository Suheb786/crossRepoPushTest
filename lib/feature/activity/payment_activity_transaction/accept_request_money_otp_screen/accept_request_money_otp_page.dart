import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'accept_request_money_otp_page_view.dart';
import 'accept_request_money_otp_page_view_model.dart';

class AcceptRequestMoneyOtpPage extends BasePage<AcceptRequestMoneyOtpPageViewModel> {
  final AcceptRequestMoneyOtpPageArgument argument;

  AcceptRequestMoneyOtpPage(this.argument);

  @override
  AcceptRequestMoneyOtpPageState createState() => AcceptRequestMoneyOtpPageState();
}

class AcceptRequestMoneyOtpPageState
    extends BaseStatefulPage<AcceptRequestMoneyOtpPageViewModel, AcceptRequestMoneyOtpPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  AcceptRequestMoneyOtpPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return acceptRequestMoneyOtpPageViewModelProvider.call(widget.argument);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(AcceptRequestMoneyOtpPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
    super.onModelReady(model);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(BuildContext context, AcceptRequestMoneyOtpPageViewModel model) {
    return AcceptRequestMoneyOtpPageView(provideBase());
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
    getViewModel().otpController.text = code!;
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }
}

class AcceptRequestMoneyOtpPageArgument {
  final ApproveRtpData approveRtpData;
  final String mobileCode;
  final String mobileNumber;

  AcceptRequestMoneyOtpPageArgument(
      {required this.approveRtpData, required this.mobileCode, required this.mobileNumber});
}
