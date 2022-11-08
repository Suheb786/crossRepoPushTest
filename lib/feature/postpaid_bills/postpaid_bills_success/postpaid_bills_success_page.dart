import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/postpaid_bills_success/postpaid_bills_success_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/postpaid_bills_success/postpaid_bills_success_page_view_model.dart';

class PostPaidBillsSuccessPage extends BasePage<PostPaidBillsSuccessPageViewModel> {
  final PostPaidBillsSuccessPageArguments arguments;

  PostPaidBillsSuccessPage(this.arguments);

  @override
  PostPaidBillsSuccessPageState createState() => PostPaidBillsSuccessPageState();
}

class PostPaidBillsSuccessPageState
    extends BaseStatefulPage<PostPaidBillsSuccessPageViewModel, PostPaidBillsSuccessPage> {
  @override
  ProviderBase provideBase() {
    return postPaidBillsSuccessPageViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, PostPaidBillsSuccessPageViewModel model) {
    return PostPaidBillsSuccessPageView(provideBase());
  }
}

class PostPaidBillsSuccessPageArguments {
  final String amt;

  final List<dynamic> noOfSelectedBills;

  PostPaidBillsSuccessPageArguments(
    this.noOfSelectedBills,
    this.amt,
  );
}
