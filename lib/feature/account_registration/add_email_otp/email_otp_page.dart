import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/add_email_otp/email_otp_model.dart';
import 'package:neo_bank/feature/account_registration/add_email_otp/email_otp_view.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EmailOtpPage extends BasePage<EmailOtpViewModel> {
  @override
  EmailOtpPageState createState() => EmailOtpPageState();
}

class EmailOtpPageState extends BaseStatefulPage<EmailOtpViewModel, EmailOtpPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  EmailOtpPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return emailOtpViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(EmailOtpViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, EmailOtpViewModel model) {
    return EmailOtpPageView(provideBase());
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
