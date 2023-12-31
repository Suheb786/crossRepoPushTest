import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_model.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_view.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ValidateOtpPage extends BasePage<ValidateOtpViewModel> {
  @override
  ValidateOtpPageState createState() => ValidateOtpPageState();
}

class ValidateOtpPageState extends BaseStatefulPage<ValidateOtpViewModel, ValidateOtpPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  ValidateOtpPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return validateOtpViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(ValidateOtpViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, ValidateOtpViewModel model) {
    return ValidateOtpPageView(provideBase());
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
  Future<bool> onBackPressed(ValidateOtpViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(accountRegistrationViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      if (parentModel.appSwiperController.page! > 1) {
        return false;
      } else {
        parentModel.previousPage();
        return false;
      }
    } else {
      return super.onBackPressed(model);
    }
  }
}
