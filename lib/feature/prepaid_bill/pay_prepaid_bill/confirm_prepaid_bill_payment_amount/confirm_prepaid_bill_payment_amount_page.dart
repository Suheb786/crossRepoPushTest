import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';

import 'confirm_prepaid_bill_payment_amount_page_view.dart';
import 'confirm_prepaid_bill_payment_amount_page_view_model.dart';

class ConfirmPrePaidBillPaymentAmountPage extends BasePage<ConfirmPrePaidBillPaymentAmountPageViewModel> {
  @override
  ConfirmPrePaidBillPaymentAmountPageState createState() => ConfirmPrePaidBillPaymentAmountPageState();
}

class ConfirmPrePaidBillPaymentAmountPageState extends BaseStatefulPage<
    ConfirmPrePaidBillPaymentAmountPageViewModel,
    ConfirmPrePaidBillPaymentAmountPage> with AutomaticKeepAliveClientMixin {
  ConfirmPrePaidBillPaymentAmountPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return confirmPrePaidBillPaymentAmountPageViewModelProvider;
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
  Widget buildView(BuildContext context, ConfirmPrePaidBillPaymentAmountPageViewModel model) {
    return ConfirmPrePaidBillPaymentAmountPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
