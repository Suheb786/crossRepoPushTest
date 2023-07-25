import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/enter_code_for_change_mobile_number/enter_code_for_change_mobile_number_page_view.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/enter_code_for_change_mobile_number/enter_code_for_change_mobile_number_page_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterCodeForChangeMobileNumberPage extends BasePage<EnterCodeForChangeMobileNumberPageViewModel> {
  @override
  EnterCodeForChangeMobileNumberPageState createState() => EnterCodeForChangeMobileNumberPageState();
}

class EnterCodeForChangeMobileNumberPageState
    extends BaseStatefulPage<EnterCodeForChangeMobileNumberPageViewModel, EnterCodeForChangeMobileNumberPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  EnterCodeForChangeMobileNumberPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return enterOtpForNewMobileNumberViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(EnterCodeForChangeMobileNumberPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, EnterCodeForChangeMobileNumberPageViewModel model) {
    return EnterCodeForChangeMobileNumberPageView(provideBase());
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
