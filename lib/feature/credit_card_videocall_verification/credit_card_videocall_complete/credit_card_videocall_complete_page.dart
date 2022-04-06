import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_complete/credit_card_videocall_complete_page_view.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_complete/credit_card_videocall_complete_page_view_model.dart';

class CreditCardVideoCallCompletePage
    extends BasePage<CreditCardVideoCallCompletePageViewModel> {
  @override
  CreditCardVideoCallCompletePageState createState() =>
      CreditCardVideoCallCompletePageState();
}

class CreditCardVideoCallCompletePageState extends BaseStatefulPage<
    CreditCardVideoCallCompletePageViewModel, CreditCardVideoCallCompletePage> {
  @override
  ProviderBase provideBase() {
    return creditCardVideoCallCompleteViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(
      BuildContext context, CreditCardVideoCallCompletePageViewModel model) {
    return CreditCardVideoCallCompletePageView(provideBase());
  }
}
