import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_debit_card/personalize_debit_card/personalize_debit_card_page_view.dart';
import 'package:neo_bank/feature/supplementary_debit_card/personalize_debit_card/personalize_debit_card_page_view_model.dart';

class PersonalizeDebitCardPage extends BasePage<PersonalizeDebitCardPageViewModel> {
  @override
  PersonalizeDebitCardPageState createState() => PersonalizeDebitCardPageState();
}

class PersonalizeDebitCardPageState
    extends BaseStatefulPage<PersonalizeDebitCardPageViewModel, PersonalizeDebitCardPage> {
  @override
  ProviderBase provideBase() {
    return personalizeDebitViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, PersonalizeDebitCardPageViewModel model) {
    return PersonalizeDebitCardPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }
}
