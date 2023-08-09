import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../purchase_evoucher_without_region_page.dart';
import 'otp_purchase_evoucher_without_region_page_view.dart';
import 'otp_purchase_evoucher_without_region_page_view_model.dart';

class PurchaseEVoucherWithoutRegionPage extends BasePage<OtpPurchaseEvoucherWithoutRegionPageViewModel> {
  final PurchaseEVoucherWithoutRegionPageArgument argument;

  PurchaseEVoucherWithoutRegionPage(this.argument);

  @override
  EnterOtpForEVoucherCategoryPurchasePageState createState() =>
      EnterOtpForEVoucherCategoryPurchasePageState();
}

class EnterOtpForEVoucherCategoryPurchasePageState
    extends BaseStatefulPage<OtpPurchaseEvoucherWithoutRegionPageViewModel, PurchaseEVoucherWithoutRegionPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  EnterOtpForEVoucherCategoryPurchasePageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return otpPurchaseEvoucherWithoutRegionPageViewModelProvider.call(widget.argument);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(OtpPurchaseEvoucherWithoutRegionPageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, OtpPurchaseEvoucherWithoutRegionPageViewModel model) {
    return OtpPurchaseEvoucherWithoutRegionPageView(provideBase());
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
    getViewModel().otpController.text = code!;
  }

  @override
  void dispose() {
    print('inside dispose');
    super.dispose();
    cancel();
  }
}
