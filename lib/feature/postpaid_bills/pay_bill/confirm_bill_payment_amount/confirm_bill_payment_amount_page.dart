import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';

import 'confirm_bill_payment_amount_page_view.dart';
import 'confirm_bill_payment_amount_page_view_model.dart';

class ConfirmBillPaymentAmountPage extends BasePage<ConfirmBillPaymentAmountPageViewModel> {
  @override
  ConfirmBillPaymentAmountPageState createState() => ConfirmBillPaymentAmountPageState();
}

class ConfirmBillPaymentAmountPageState
    extends BaseStatefulPage<ConfirmBillPaymentAmountPageViewModel, ConfirmBillPaymentAmountPage>
    with AutomaticKeepAliveClientMixin {
  ConfirmBillPaymentAmountPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return confirmBillPaymentAmountPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Widget buildView(BuildContext context, ConfirmBillPaymentAmountPageViewModel model) {
    return ConfirmBillPaymentAmountPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
