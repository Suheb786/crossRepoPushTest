import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity/payment_activity_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity/payment_activity_view_model.dart';

class PaymentActivityPage extends BasePage<PaymentActivityViewModel> {
  @override
  PaymentActivityPageState createState() => PaymentActivityPageState();
}

class PaymentActivityPageState extends BaseStatefulPage<PaymentActivityViewModel, PaymentActivityPage>
    with AutomaticKeepAliveClientMixin {
  @override
  ProviderBase provideBase() {
    return paymentActivityViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, PaymentActivityViewModel model) {
    return PaymentActivityPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
