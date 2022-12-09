import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/prepaid_bill/paying_prepaid_bills/paying_prepaid_bills_page_view.dart';
import 'package:neo_bank/feature/prepaid_bill/paying_prepaid_bills/paying_prepaid_bills_page_view_model.dart';

class PayingPrePaidBillsPage extends BasePage<PayingPrePaidBillsPageViewModel> {
  final PayingPrePaidBillsPageArgument argument;

  PayingPrePaidBillsPage(this.argument);

  @override
  PayingPrePaidBillsPageState createState() => PayingPrePaidBillsPageState();
}

class PayingPrePaidBillsPageState
    extends BaseStatefulPage<PayingPrePaidBillsPageViewModel, PayingPrePaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return payingPrePaidBillsPageViewModelProvider.call(widget.argument);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, PayingPrePaidBillsPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, child: PayingPrePaidBillsPageView(provideBase()));
  }
}

class PayingPrePaidBillsPageArgument {
  final List<GetPrepaidBillerListModelData> payMyPrePaidBillsPageDataList;

  PayingPrePaidBillsPageArgument(this.payMyPrePaidBillsPageDataList);
}
