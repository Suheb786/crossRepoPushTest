import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/forgot_password/forgot_password_modules.dart';
import 'package:neo_bank/feature/forgot_password/enter_otp_for_reset_password/enter_otp_for_reset_password_page_view.dart';
import 'package:neo_bank/feature/forgot_password/enter_otp_for_reset_password/enter_otp_for_reset_password_page_view_model.dart';

class EnterOTPForResetPasswordPage
    extends BasePage<EnterOTPForResetPasswordPageViewModel> {
  @override
  EnterOTPForResetPasswordPageState createState() =>
      EnterOTPForResetPasswordPageState();
}

class EnterOTPForResetPasswordPageState extends BaseStatefulPage<
        EnterOTPForResetPasswordPageViewModel, EnterOTPForResetPasswordPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  EnterOTPForResetPasswordPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return enterOtpForResetPasswordViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(EnterOTPForResetPasswordPageViewModel model) {
    model.countDownController =
        CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(
      BuildContext context, EnterOTPForResetPasswordPageViewModel model) {
    return EnterOTPForResetPasswordPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
