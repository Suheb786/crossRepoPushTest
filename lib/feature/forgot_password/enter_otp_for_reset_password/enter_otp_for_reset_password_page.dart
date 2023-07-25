import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/forgot_password/forgot_password_modules.dart';
import 'package:neo_bank/feature/forgot_password/enter_otp_for_reset_password/enter_otp_for_reset_password_page_view.dart';
import 'package:neo_bank/feature/forgot_password/enter_otp_for_reset_password/enter_otp_for_reset_password_page_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterOTPForResetPasswordPage extends BasePage<EnterOTPForResetPasswordPageViewModel> {
  @override
  EnterOTPForResetPasswordPageState createState() => EnterOTPForResetPasswordPageState();
}

class EnterOTPForResetPasswordPageState
    extends BaseStatefulPage<EnterOTPForResetPasswordPageViewModel, EnterOTPForResetPasswordPage>
    with TickerProviderStateMixin, CodeAutoFill {
  @override
  ProviderBase provideBase() {
    return enterOtpForResetPasswordViewModelProvider;
  }

  @override
  void onModelReady(EnterOTPForResetPasswordPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, EnterOTPForResetPasswordPageViewModel model) {
    return EnterOTPForResetPasswordPageView(provideBase());
  }

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
