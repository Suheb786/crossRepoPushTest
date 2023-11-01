import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/enter_otp/enter_otp_page_view.dart';
import 'package:neo_bank/feature/payment/enter_otp/enter_otp_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterOtpPage extends BasePage<EnterOtpViewModel> {
  @override
  EnterOtpPageState createState() => EnterOtpPageState();
}

class EnterOtpPageState extends BaseStatefulPage<EnterOtpViewModel, EnterOtpPage> with CodeAutoFill {
  @override
  ProviderBase provideBase() {
    return enterOtpViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  void onModelReady(EnterOtpViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Widget buildView(BuildContext context, EnterOtpViewModel model) {
    return EnterOtpPageView(provideBase());
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

  @override
  Future<bool> onBackPressed(EnterOtpViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context)
        .read(paymentToNewRecipientViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
