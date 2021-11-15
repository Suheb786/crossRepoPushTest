import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_model.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_view.dart';

class ValidateOtpPage extends BasePage<ValidateOtpViewModel> {
  @override
  ValidateOtpPageState createState() => ValidateOtpPageState();
}

class ValidateOtpPageState
    extends BaseStatefulPage<ValidateOtpViewModel, ValidateOtpPage>
    with TickerProviderStateMixin {
  @override
  ProviderBase provideBase() {
    return validateOtpViewModelProvider;
  }

  @override
  void onModelReady(ValidateOtpViewModel model) {
    model.countDownController =
        CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, ValidateOtpViewModel model) {
    return ValidateOtpPageView(provideBase());
  }
}
