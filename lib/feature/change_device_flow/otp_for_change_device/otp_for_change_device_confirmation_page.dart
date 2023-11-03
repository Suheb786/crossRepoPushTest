import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/change_Device/change_device_modules.dart';
import 'package:neo_bank/feature/change_device_flow/otp_for_change_device/otp_for_change_device_confirmation_page_view.dart';
import 'package:neo_bank/feature/change_device_flow/otp_for_change_device/otp_for_change_device_confirmation_page_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpForChangeDeviceConfirmationPage extends BasePage<OtpForChangeDeviceConfirmationPageViewModel> {
  final OtpForChangeDeviceConfirmationPageArguments arguments;

  OtpForChangeDeviceConfirmationPage(this.arguments);

  @override
  OtpForChangeDeviceConfirmationPageState createState() => OtpForChangeDeviceConfirmationPageState();
}

class OtpForChangeDeviceConfirmationPageState
    extends BaseStatefulPage<OtpForChangeDeviceConfirmationPageViewModel, OtpForChangeDeviceConfirmationPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  OtpForChangeDeviceConfirmationPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return otpForChangeDeviceViewModelProvider.call(widget.arguments);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(OtpForChangeDeviceConfirmationPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
    super.onModelReady(model);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, OtpForChangeDeviceConfirmationPageViewModel model) {
    return OtpForChangeDeviceConfirmationPageView(provideBase());
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

  @override
  Future<bool> onBackPressed(OtpForChangeDeviceConfirmationPageViewModel model, {param}) async {
    return false;
  }
}

class OtpForChangeDeviceConfirmationPageArguments {
  final String mobileCode;
  final String mobileNumber;
  final String journeyId;

  OtpForChangeDeviceConfirmationPageArguments({required this.mobileCode, required this.mobileNumber,required this.journeyId});
}
