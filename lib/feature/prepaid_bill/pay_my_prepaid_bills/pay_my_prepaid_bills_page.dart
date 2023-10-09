import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/prepaid_bill/pay_my_prepaid_bills/pay_my_prepaid_bills_page_view.dart';
import 'package:neo_bank/feature/prepaid_bill/pay_my_prepaid_bills/pay_my_prepaid_bills_page_view_model.dart';

class PayMyPrePaidBillsPage extends BasePage<PayMyPrePaidBillsPageViewModel> {
  final bool needBackButton;

  PayMyPrePaidBillsPage({this.needBackButton = false});

  @override
  PayMyPrePaidBillsPageState createState() => PayMyPrePaidBillsPageState();
}

class PayMyPrePaidBillsPageState
    extends BaseStatefulPage<PayMyPrePaidBillsPageViewModel, PayMyPrePaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return payMyPrePaidBillsPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  void onModelReady(PayMyPrePaidBillsPageViewModel model) {
    model.setShowBackButton(widget.needBackButton);
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, PayMyPrePaidBillsPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, child: PayMyPrePaidBillsPageView(provideBase()));
  }
}
