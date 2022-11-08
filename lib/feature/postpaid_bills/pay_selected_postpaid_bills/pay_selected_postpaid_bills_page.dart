import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_selected_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page_view_model.dart';

class PaySelectedBillsPostPaidBillsPage extends BasePage<PaySelectedBillsPostPaidBillsPageViewModel> {
  final PaySelectedBillsPostPaidBillsPageArguments arguments;

  PaySelectedBillsPostPaidBillsPage(this.arguments);

  @override
  PaySelectedBillsPostPaidBillsPageState createState() => PaySelectedBillsPostPaidBillsPageState();
}

class PaySelectedBillsPostPaidBillsPageState
    extends BaseStatefulPage<PaySelectedBillsPostPaidBillsPageViewModel, PaySelectedBillsPostPaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return paySelectedBillsPostPaidBillsPageViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, PaySelectedBillsPostPaidBillsPageViewModel model) {
    return PaySelectedBillsPostPaidBillsPageView(provideBase());
  }
}

class PaySelectedBillsPostPaidBillsPageArguments {
  final String nosOfBills;
  final String amt;
  final List<PallAllPostPaidBillsData> noOfSelectedBills;

  PaySelectedBillsPostPaidBillsPageArguments(this.nosOfBills, this.amt, this.noOfSelectedBills);
}
