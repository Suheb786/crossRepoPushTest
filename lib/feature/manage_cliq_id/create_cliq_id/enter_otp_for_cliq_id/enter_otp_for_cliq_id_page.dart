import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/enter_otp_for_cliq_id/enter_otp_for_cliq_id_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/enter_otp_for_cliq_id/enter_otp_for_cliq_id_page_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterOtpForCliqIdPage extends BasePage<EnterOtpForCliqIdPageViewModel> {
  @override
  EnterOtpForCliqIdPageState createState() => EnterOtpForCliqIdPageState();
}

class EnterOtpForCliqIdPageState extends BaseStatefulPage<
        EnterOtpForCliqIdPageViewModel, EnterOtpForCliqIdPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  EnterOtpForCliqIdPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return enterOtpFortCliqIdViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(EnterOtpForCliqIdPageViewModel model) {
    model.countDownController =
        CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, EnterOtpForCliqIdPageViewModel model) {
    return EnterOtpForCliqIdPageView(provideBase());
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
  Future<bool> onBackPressed(EnterOtpForCliqIdPageViewModel model,
      {param}) async {
    var parentModel =
        ProviderScope.containerOf(context).read(createCliqIdViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }
}
