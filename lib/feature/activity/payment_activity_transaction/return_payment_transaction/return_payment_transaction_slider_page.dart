import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_transaction_slider_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_transaction_slider_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

class ReturnPaymentTransactionSliderPage extends BasePage<ReturnPaymentTransactionSliderPageViewModel> {
  @override
  State<StatefulWidget> createState() {
    return ReturnPaymentTransactionSliderState();
  }
}

class ReturnPaymentTransactionSliderState extends BaseStatefulPage<
    ReturnPaymentTransactionSliderPageViewModel, ReturnPaymentTransactionSliderPage> {
  @override
  Widget buildView(BuildContext context, ReturnPaymentTransactionSliderPageViewModel model) {
    return ReturnPaymentTransactionSliderPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return returnPaymentTransactionSliderPageViewModelProvider;
  }
}
