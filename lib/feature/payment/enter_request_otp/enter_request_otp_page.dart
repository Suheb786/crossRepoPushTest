import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/enter_request_otp/enter_request_otp_page_view.dart';
import 'package:neo_bank/feature/payment/enter_request_otp/enter_request_otp_view_model.dart';

class EnterRequestOtpPage extends BasePage<EnterRequestOtpViewModel> {
  @override
  EnterRequestOtpPageState createState() => EnterRequestOtpPageState();
}

class EnterRequestOtpPageState
    extends BaseStatefulPage<EnterRequestOtpViewModel, EnterRequestOtpPage> {
  @override
  ProviderBase provideBase() {
    return enterRequestOtpViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  void onModelReady(EnterRequestOtpViewModel model) {
    model.countDownController =
        CountdownTimerController(endTime: model.endTime);
  }

  @override
  Widget buildView(BuildContext context, EnterRequestOtpViewModel model) {
    return EnterRequestOtpPageView(provideBase());
  }
}
