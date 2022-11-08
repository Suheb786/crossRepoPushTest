import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/change_card_pin_success/card_ready_success_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin_success/change_card_pin_success_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page_view_model.dart';

import 'package:neo_bank/utils/color_utils.dart';

class PayAllPostPaidBillsPage extends BasePage<PayAllPostPaidBillsPageViewModel> {
  @override
  PayAllPostPaidBillsPageState createState() => PayAllPostPaidBillsPageState();
}

class PayAllPostPaidBillsPageState
    extends BaseStatefulPage<PayAllPostPaidBillsPageViewModel, PayAllPostPaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return payAllPostPaidBillsPageViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() {
    return AppColor.black;
  }

  @override
  Widget buildView(BuildContext context, PayAllPostPaidBillsPageViewModel model) {
    return PayAllPostPaidBillsPageView(provideBase());
  }
}
