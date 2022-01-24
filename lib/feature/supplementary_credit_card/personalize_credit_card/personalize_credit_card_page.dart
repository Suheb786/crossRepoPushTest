import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_credit_card/personalize_credit_card/personalize_credit_card_page_view.dart';
import 'package:neo_bank/feature/supplementary_credit_card/personalize_credit_card/personalize_credit_card_page_view_model.dart';

class PersonalizeCreditCardPage
    extends BasePage<PersonalizeCreditCardPageViewModel> {
  @override
  PersonalizeCreditCardPageState createState() =>
      PersonalizeCreditCardPageState();
}

class PersonalizeCreditCardPageState extends BaseStatefulPage<
    PersonalizeCreditCardPageViewModel, PersonalizeCreditCardPage> {
  @override
  ProviderBase provideBase() {
    return personalizeCreditCardViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, PersonalizeCreditCardPageViewModel model) {
    return PersonalizeCreditCardPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}
