import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_initiate/credit_card_videocall_initiate_page_view.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_initiate/credit_card_videocall_initiate_page_view_model.dart';

class CreditCardVideoCallInitiatePage extends BasePage<CreditCardVideoCallInitiatePageViewModel> {
  final CreditCardVideoCallInitiateArgs _creditCardVideoCallInitiateArgs;

  CreditCardVideoCallInitiatePage(this._creditCardVideoCallInitiateArgs);

  @override
  CreditCardVideoCallInitiatePageState createState() => CreditCardVideoCallInitiatePageState();
}

class CreditCardVideoCallInitiatePageState
    extends BaseStatefulPage<CreditCardVideoCallInitiatePageViewModel, CreditCardVideoCallInitiatePage> {
  @override
  ProviderBase provideBase() {
    return creditCardVideoCallInitiateViewModelProvider.call(widget._creditCardVideoCallInitiateArgs);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  void onModelReady(CreditCardVideoCallInitiatePageViewModel model) {
    super.onModelReady(model);

  }

  @override
  Widget buildView(BuildContext context, CreditCardVideoCallInitiatePageViewModel model) {
    return CreditCardVideoCallInitiatePageView(provideBase());
  }
}

class CreditCardVideoCallInitiateArgs {
  final CreditCard creditCard;

  CreditCardVideoCallInitiateArgs({required this.creditCard});
}
