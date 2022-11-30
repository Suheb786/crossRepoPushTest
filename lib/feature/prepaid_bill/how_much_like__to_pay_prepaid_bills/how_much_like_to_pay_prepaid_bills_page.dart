import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/prepaid_bill/pay_my_prepaid_bills/pay_my_prepaid_bills_page_view_model.dart';

import 'how_much_like_to_pay_prepaid_bills_page_view.dart';
import 'how_much_like_to_pay_prepaid_bills_page_view_model.dart';

class HowMuchLikeToPayPrePaidBillsPage
    extends BasePage<HowMuchLikeToPayPrePaidBillsPageViewModel> {
  final HowMuchLikeToPayPrePaidBillsPageArgument argument;

  HowMuchLikeToPayPrePaidBillsPage(this.argument);

  @override
  HowMuchLikeToPayPrePaidBillsPageState createState() =>
      HowMuchLikeToPayPrePaidBillsPageState();
}

class HowMuchLikeToPayPrePaidBillsPageState extends BaseStatefulPage<
    HowMuchLikeToPayPrePaidBillsPageViewModel,
    HowMuchLikeToPayPrePaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return howMuchLikeToPayPrePaidBillsPageViewModelProvider
        .call(widget.argument);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(
      BuildContext context, HowMuchLikeToPayPrePaidBillsPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: HowMuchLikeToPayPrePaidBillsPageView(provideBase()));
  }
}

class HowMuchLikeToPayPrePaidBillsPageArgument {
  final List<GetPrepaidBillerListModelData> payMyPrePaidBillsPageDataList;

  HowMuchLikeToPayPrePaidBillsPageArgument(this.payMyPrePaidBillsPageDataList);
}
