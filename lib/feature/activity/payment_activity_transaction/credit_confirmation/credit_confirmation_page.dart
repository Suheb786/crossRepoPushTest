// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

class CreditConfirmationPaymentActivityPage extends BasePage<CreditConfirmationPaymentActivityViewModel> {
  final CreditConfirmationArgument creditConfirmationArgument;

  CreditConfirmationPaymentActivityPage(this.creditConfirmationArgument);

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
    return creditConfirmationPageViewModelProvider.call(widget.creditConfirmationArgument);
  }
}

class CreditConfirmationArgument {
  final String? amount;
  final String? crediterName;
  final String? accountNo;
  final String? crediterDP;
  final String? transactionType;
  final String? date;
  final String? time;
  final String? refID;
  final String? msgID;
  final String? currency;

  CreditConfirmationArgument({
    required this.amount,
    required this.crediterName,
    required this.accountNo,
    required this.crediterDP,
    required this.transactionType,
    required this.date,
    required this.time,
    required this.refID,
    required this.msgID,
    required this.currency,
  });
}
