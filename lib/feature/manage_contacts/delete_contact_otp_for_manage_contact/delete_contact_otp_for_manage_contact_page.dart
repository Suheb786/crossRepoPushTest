import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'delete_contact_otp_for_manage_contact_page_view.dart';
import 'delete_contact_otp_for_manage_contact_page_view_model.dart';

class DeleteContactOTPPage extends BasePage<DeleteContactOTPPageViewModel> {
  @override
  OtpForManageContactPageState createState() => OtpForManageContactPageState();
}

class OtpForManageContactPageState
    extends BaseStatefulPage<DeleteContactOTPPageViewModel, DeleteContactOTPPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  OtpForManageContactPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return otpForManageContactPageViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(DeleteContactOTPPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);

    super.onModelReady(model);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, DeleteContactOTPPageViewModel model) {
    return DeleteContactOTPPageView(provideBase());
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
