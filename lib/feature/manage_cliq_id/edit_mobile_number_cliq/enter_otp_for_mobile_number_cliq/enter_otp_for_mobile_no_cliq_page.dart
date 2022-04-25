import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/enter_otp_for_mobile_number_cliq/enter_otp_for_mobile_no_cliq_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/enter_otp_for_mobile_number_cliq/enter_otp_for_mobile_no_cliq_page_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterOtpForMobileNumberCliqPage
    extends BasePage<EnterOtpForMobileNumberCliqPageViewModel> {
  @override
  EnterOtpForMobileNumberCliqPageState createState() =>
      EnterOtpForMobileNumberCliqPageState();
}

class EnterOtpForMobileNumberCliqPageState extends BaseStatefulPage<
        EnterOtpForMobileNumberCliqPageViewModel,
        EnterOtpForMobileNumberCliqPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  EnterOtpForMobileNumberCliqPageState()
      : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return enterOtpForMobileNoCliqViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(EnterOtpForMobileNumberCliqPageViewModel model) {
    model.countDownController =
        CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(
      BuildContext context, EnterOtpForMobileNumberCliqPageViewModel model) {
    return EnterOtpForMobileNumberCliqPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {});
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
