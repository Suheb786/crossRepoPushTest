import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/prepaid_bill/prepaid_bills_success/prepaid_bills_success_page_view.dart';
import 'package:neo_bank/feature/prepaid_bill/prepaid_bills_success/prepaid_bills_success_page_view_model.dart';

class PrePaidBillsSuccessPage extends BasePage<PrePaidBillsSuccessPageViewModel> {
  final PrePaidBillsSuccessPageArguments arguments;

  PrePaidBillsSuccessPage(this.arguments);

  @override
  PrePaidBillsSuccessPageState createState() => PrePaidBillsSuccessPageState();
}

class PrePaidBillsSuccessPageState
    extends BaseStatefulPage<PrePaidBillsSuccessPageViewModel, PrePaidBillsSuccessPage> {
  @override
  ProviderBase provideBase() {
    return prePaidBillsSuccessPageViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, PrePaidBillsSuccessPageViewModel model) {
    return PrePaidBillsSuccessPageView(provideBase());
  }
}

class PrePaidBillsSuccessPageArguments {
  final String amt;
  final String billName;
  final String nickName;
  final String refNo;

  PrePaidBillsSuccessPageArguments(this.amt, this.billName, this.nickName, this.refNo);
}
