import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:riverpod/src/framework.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'add_beneficiary_otp_page_view.dart';
import 'add_beneficiary_otp_page_view_model.dart';

class AddBeneficiaryOTPPage extends BasePage<AddBeneficiaryotpPageViewModel> {
  @override
  State<StatefulWidget> createState() => AddBeneficiaryOTPPageState();
}

class AddBeneficiaryOTPPageState
    extends BaseStatefulPage<AddBeneficiaryotpPageViewModel, AddBeneficiaryOTPPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  AddBeneficiaryOTPPageState() : super(subscribeVisibilityEvents: true);

  @override
  Widget buildView(BuildContext context, AddBeneficiaryotpPageViewModel model) =>
      AddBeneficiaryotpPageView(provideBase());

  @override
  ProviderBase provideBase() => addBeneficiaryotpPageViewModel;

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  void onModelReady(AddBeneficiaryotpPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
    super.onModelReady(model);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
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
