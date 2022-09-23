import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page_view.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page_view_model.dart';

class CreditCardApplySuccessPage extends BasePage<CreditCardApplySuccessPageViewModel> {
  final CreditCardApplySuccessArguments _creditCardApplySuccessArguments;

  CreditCardApplySuccessPage(this._creditCardApplySuccessArguments);

  @override
  CreditCardApplySuccessPageState createState() => CreditCardApplySuccessPageState();
}

class CreditCardApplySuccessPageState
    extends BaseStatefulPage<CreditCardApplySuccessPageViewModel, CreditCardApplySuccessPage> {
  @override
  ProviderBase provideBase() {
    return creditCardApplySuccessViewModelProvider.call(widget._creditCardApplySuccessArguments);
  }

  @override
  Widget buildView(BuildContext context, CreditCardApplySuccessPageViewModel model) {
    return CreditCardApplySuccessPageView(provideBase());
  }
}

enum CreditSuccessState {
  Submitted,
  Applied_Success,
  Settlement_Account_Changed,
  Settlement_Percentage_Changed,
  Credit_Limit_Changed,
  Convert_Purchase_To_Installments
}

class CreditCardApplySuccessArguments {
  final CreditSuccessState creditSuccessState;

  CreditCardApplySuccessArguments({this.creditSuccessState: CreditSuccessState.Applied_Success});
}
