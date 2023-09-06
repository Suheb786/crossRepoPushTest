import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_otp_validate/rj_otp_validate_page_view.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_otp_validate/rj_otp_validate_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RjOtpValidatePage extends BasePage<RjOtpValidateViewModel> {
  @override
  RjOtpValidatePageState createState() => RjOtpValidatePageState();
}

class RjOtpValidatePageState extends BaseStatefulPage<RjOtpValidateViewModel, RjOtpValidatePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  RjOtpValidatePageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return rjOtpValidateViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(RjOtpValidateViewModel model) {
    // model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  // @override
  // void onFocusLost() {
  //   getViewModel().countDownController.disposeTimer();
  //   super.onFocusLost();
  // }

  @override
  Widget buildView(BuildContext context, RjOtpValidateViewModel model) {
    return RjOtpValidatePageView(provideBase());
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
