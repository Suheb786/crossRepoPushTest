import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/bill_payments_transaction/bill_payments_transaction_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/bill_payments_transaction/bill_payments_transaction_view_model.dart';

class BillPaymentsTransactionPage extends BasePage<BillPaymentsTransactionViewModel> {
  @override
  BillPaymentsTransactionPageState createState() => BillPaymentsTransactionPageState();
}

class BillPaymentsTransactionPageState
    extends BaseStatefulPage<BillPaymentsTransactionViewModel, BillPaymentsTransactionPage> {
  @override
  ProviderBase provideBase() {
    return billPaymentsTransactionViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Future<bool> onBackPressed(BillPaymentsTransactionViewModel model, {param}) {
    ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).animateBackToMainPage();
    return super.onBackPressed(model);
  }

  @override
  Widget buildView(BuildContext context, BillPaymentsTransactionViewModel model) {
    return BillPaymentsTransactionPageView(provideBase());
  }
}
