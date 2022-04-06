import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_initiate/credit_card_videocall_initiate_page_view.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_initiate/credit_card_videocall_initiate_page_view_model.dart';

class CreditCardVideoCallInitiatePage
    extends BasePage<CreditCardVideoCallInitiatePageViewModel> {
  @override
  CreditCardVideoCallInitiatePageState createState() =>
      CreditCardVideoCallInitiatePageState();
}

class CreditCardVideoCallInitiatePageState extends BaseStatefulPage<
    CreditCardVideoCallInitiatePageViewModel, CreditCardVideoCallInitiatePage> {
  @override
  ProviderBase provideBase() {
    return creditCardVideoCallInitiateViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(
      BuildContext context, CreditCardVideoCallInitiatePageViewModel model) {
    return CreditCardVideoCallInitiatePageView(provideBase());
  }
}
