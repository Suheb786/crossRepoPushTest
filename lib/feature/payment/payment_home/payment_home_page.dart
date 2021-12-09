import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_page_view.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';

class PaymentHomePage extends BasePage<PaymentHomeViewModel> {
  @override
  PaymentHomePageState createState() => PaymentHomePageState();
}

class PaymentHomePageState
    extends BaseStatefulPage<PaymentHomeViewModel, PaymentHomePage> {
  @override
  ProviderBase provideBase() {
    return paymentHomeViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, PaymentHomeViewModel model) {
    return PaymentHomePageView(provideBase());
  }
}
