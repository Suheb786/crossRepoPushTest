import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/enter_code_evoucher_puchase/enter_code_evoucher_puchase_page_view.dart';
import 'package:neo_bank/feature/evoucher/enter_code_evoucher_puchase/enter_code_evoucher_puchase_page_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterCodeEVoucherPurchasePage extends BasePage<EnterCodeEVoucherPurchasePageViewModel> {
  @override
  EnterCodeEVoucherPurchasePageState createState() => EnterCodeEVoucherPurchasePageState();
}

class EnterCodeEVoucherPurchasePageState
    extends BaseStatefulPage<EnterCodeEVoucherPurchasePageViewModel, EnterCodeEVoucherPurchasePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  EnterCodeEVoucherPurchasePageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return enterCodeEVoucherPurchaseViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(EnterCodeEVoucherPurchasePageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, EnterCodeEVoucherPurchasePageViewModel model) {
    return EnterCodeEVoucherPurchasePageView(provideBase());
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
