import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/validateotp/validate_otp_model.dart';
import 'package:neo_bank/feature/register/stepone/validateotp/validate_otp_view.dart';

class ValidateOtpPage extends BasePage<ValidateOtpViewModel> {
  @override
  ValidateOtpPageState createState() => ValidateOtpPageState();
}

class ValidateOtpPageState
    extends BaseStatefulPage<ValidateOtpViewModel, ValidateOtpPage> {
  @override
  ProviderBase provideBase() {
    return validateOtpViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ValidateOtpViewModel model) {
    return ValidateOtpPageView(provideBase());
  }
}
