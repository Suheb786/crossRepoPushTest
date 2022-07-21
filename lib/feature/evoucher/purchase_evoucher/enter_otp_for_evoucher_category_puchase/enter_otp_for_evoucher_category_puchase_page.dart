import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/enter_otp_for_evoucher_category_puchase/enter_otp_for_evoucher_category_puchase_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/enter_otp_for_evoucher_category_puchase/enter_otp_for_evoucher_category_puchase_page_view_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterOtpForEVoucherCategoryPurchasePage
    extends BasePage<EnterOtpForEVoucherCategoryPurchasePageViewModel> {
  @override
  EnterOtpForEVoucherCategoryPurchasePageState createState() =>
      EnterOtpForEVoucherCategoryPurchasePageState();
}

class EnterOtpForEVoucherCategoryPurchasePageState extends BaseStatefulPage<
        EnterOtpForEVoucherCategoryPurchasePageViewModel, EnterOtpForEVoucherCategoryPurchasePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin, CodeAutoFill {
  EnterOtpForEVoucherCategoryPurchasePageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return enterOtpForEVoucherCategoryPurchaseViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(EnterOtpForEVoucherCategoryPurchasePageViewModel model) {
    model.countDownController = CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, EnterOtpForEVoucherCategoryPurchasePageViewModel model) {
    return EnterOtpForEVoucherCategoryPurchasePageView(provideBase());
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
