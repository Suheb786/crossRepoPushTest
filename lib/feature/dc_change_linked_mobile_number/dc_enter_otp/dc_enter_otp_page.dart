import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_change_linked_mobile_number/dc_change_linked_mobile_number_module.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_otp/dc_enter_otp_page_view.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_otp/dc_enter_otp_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class DcEnterOtpPage extends BasePage<DcEnterOtpViewModel> {
  @override
  DcEnterOtpPageState createState() => DcEnterOtpPageState();
}

class DcEnterOtpPageState extends BaseStatefulPage<DcEnterOtpViewModel, DcEnterOtpPage> with CodeAutoFill {
  @override
  ProviderBase provideBase() {
    return dcEnterOtpViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  void onModelReady(DcEnterOtpViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Widget buildView(BuildContext context, DcEnterOtpViewModel model) {
    return DcEnterOtpPageView(provideBase());
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      print('inside signature---->$signature');
    });
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
