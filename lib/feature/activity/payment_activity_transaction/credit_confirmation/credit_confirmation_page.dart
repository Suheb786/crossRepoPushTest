import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

class CreditConfirmationPaymentActivityPage extends BasePage<CreditConfirmationPaymentActivityViewModel> {
  @override
  CreditConfirmationPaymentActivityPageState createState() => CreditConfirmationPaymentActivityPageState();
}

class CreditConfirmationPaymentActivityPageState extends BaseStatefulPage<
    CreditConfirmationPaymentActivityViewModel, CreditConfirmationPaymentActivityPage> {
  @override
  Widget buildView(BuildContext context, CreditConfirmationPaymentActivityViewModel model) {
    return CreditConfirmationPaymentActivityPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return creditConfirmationPageViewModelProvider;
  }
}
