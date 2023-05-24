import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'delete_beneficiary_otp_page_view.dart';
import 'delete_beneficiary_otp_page_view_model.dart';

class DeleteBeneficiaryOTPPage extends BasePage<DeleteBeneficiaryOTPPageViewModel> {
  @override
  DeleteBeneficiaryOTPPageState createState() => DeleteBeneficiaryOTPPageState();
}

class DeleteBeneficiaryOTPPageState
    extends BaseStatefulPage<DeleteBeneficiaryOTPPageViewModel, DeleteBeneficiaryOTPPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  DeleteBeneficiaryOTPPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return deleteBeneficiaryOTPViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(DeleteBeneficiaryOTPPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);

    super.onModelReady(model);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, DeleteBeneficiaryOTPPageViewModel model) {
    return DeleteBeneficiaryOTPPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;

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
    // getViewModel().otpController.text = code!;
  }

  @override
  void dispose() {
    print('inside dispose');
    super.dispose();
    cancel();
  }
}
