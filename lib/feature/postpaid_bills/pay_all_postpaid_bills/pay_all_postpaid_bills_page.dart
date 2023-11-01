import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page_view_model.dart';

class PayAllPostPaidBillsPage extends BasePage<PayAllPostPaidBillsPageViewModel> {
  final PayAllPostPaidBillsPageArguments arguments;

  PayAllPostPaidBillsPage(this.arguments);

  @override
  PayAllPostPaidBillsPageState createState() => PayAllPostPaidBillsPageState();
}

class PayAllPostPaidBillsPageState
    extends BaseStatefulPage<PayAllPostPaidBillsPageViewModel, PayAllPostPaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return payAllPostPaidBillsPageViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, PayAllPostPaidBillsPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, child: PayAllPostPaidBillsPageView(provideBase()));
  }

  @override
  Future<bool> onBackPressed(PayAllPostPaidBillsPageViewModel model, {param}) {
    ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).animateBackToMainPage();
    return super.onBackPressed(model);
  }
}

class PayAllPostPaidBillsPageArguments {
  final PostPaidBillsPayTypeOptionEnum paidBillsPayTypeOptionEnum;

  PayAllPostPaidBillsPageArguments(this.paidBillsPayTypeOptionEnum);
}
