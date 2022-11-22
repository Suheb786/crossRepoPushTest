import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';

import 'pay_prepaid_bill_page_view.dart';
import 'pay_prepaid_bill_page_view_model.dart';

class PayPrePaidBillPage extends BasePage<PayPrePaidBillPageViewModel> {
  @override
  PayPrePaidBillPageState createState() => PayPrePaidBillPageState();
}

class PayPrePaidBillPageState extends BaseStatefulPage<PayPrePaidBillPageViewModel, PayPrePaidBillPage> {
  @override
  ProviderBase provideBase() {
    return payPrePaidBillPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  void onModelReady(PayPrePaidBillPageViewModel model) {
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, PayPrePaidBillPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, child: PayPrePaidBillPageView(provideBase()));
  }
}
