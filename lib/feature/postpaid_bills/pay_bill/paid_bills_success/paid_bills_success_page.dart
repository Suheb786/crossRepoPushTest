import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/paid_bills_success/paid_bills_success_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/paid_bills_success/paid_bills_success_page_view_model.dart';

class PaidBillsSuccessPage extends BasePage<PaidBillsSuccessPageViewModel> {
  final PaidBillsSuccessPageArguments arguments;

  PaidBillsSuccessPage(this.arguments);

  @override
  PaidBillsSuccessPageState createState() => PaidBillsSuccessPageState();
}

class PaidBillsSuccessPageState
    extends BaseStatefulPage<PaidBillsSuccessPageViewModel, PaidBillsSuccessPage> {
  @override
  ProviderBase provideBase() {
    return paidBillsSuccessPageViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, PaidBillsSuccessPageViewModel model) {
    return PaidBillsSuccessPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(PaidBillsSuccessPageViewModel model, {param}) {
    Navigator.of(context)
      ..pop()
      ..pop(true);
    return super.onBackPressed(model);
  }
}

class PaidBillsSuccessPageArguments {
  final String amt;
  final String fee;
  final String billName;
  final String billNameAr;
  final String nickName;
  final String refNo;
  final bool? isPaid;

  PaidBillsSuccessPageArguments(
      this.amt, this.fee, this.billName, this.billNameAr, this.nickName, this.refNo, this.isPaid);
}
