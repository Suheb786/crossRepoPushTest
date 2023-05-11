import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/blink_credit_card/blink_credit_card_modules.dart';
import 'package:neo_bank/feature/blink_credit_card/blink_credit_card_page_view.dart';
import 'package:neo_bank/feature/blink_credit_card/blink_credit_card_view_model.dart';

class BlinkCreditCardPage extends BasePage<BlinkCreditCardViewModel> {
  @override
  BlinkCreditCardPageState createState() => BlinkCreditCardPageState();
}

class BlinkCreditCardPageState extends BaseStatefulPage<BlinkCreditCardViewModel, BlinkCreditCardPage> {
  @override
  ProviderBase provideBase() {
    return blinkCreditCardViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget buildView(BuildContext context, BlinkCreditCardViewModel model) {
    return BlinkCreditCardPageView(provideBase());
  }
}
