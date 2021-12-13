import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/enter_otp/enter_otp_page_view.dart';
import 'package:neo_bank/feature/payment/enter_otp/enter_otp_view_model.dart';

class EnterOtpPage extends BasePage<EnterOtpViewModel> {
  @override
  EnterOtpPageState createState() => EnterOtpPageState();
}

class EnterOtpPageState
    extends BaseStatefulPage<EnterOtpViewModel, EnterOtpPage> {
  @override
  ProviderBase provideBase() {
    return enterOtpViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, EnterOtpViewModel model) {
    return EnterOtpPageView(provideBase());
  }
}
