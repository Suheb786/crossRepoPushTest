import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'enter_otp_bill_payments_page_view.dart';
import 'enter_otp_bill_payments_view_model.dart';

class EnterOtpBillPaymentsPage extends BasePage<EnterOtpBillPaymentsViewModel> {
  @override
  EnterOtpBillPaymentsPageState createState() => EnterOtpBillPaymentsPageState();
}

class EnterOtpBillPaymentsPageState
    extends BaseStatefulPage<EnterOtpBillPaymentsViewModel, EnterOtpBillPaymentsPage> with CodeAutoFill {
  @override
  ProviderBase provideBase() {
    return enterOtpBillPaymentsViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  void onModelReady(EnterOtpBillPaymentsViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Widget buildView(BuildContext context, EnterOtpBillPaymentsViewModel model) {
    return EnterOtpBillPaymentsPageView(provideBase());
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
    print('inside dispose');
    super.dispose();
    cancel();
  }
}
