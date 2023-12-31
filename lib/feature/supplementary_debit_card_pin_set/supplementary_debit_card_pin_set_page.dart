import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/supplementary_debit_card_pin_set_page_view.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/supplementary_debit_card_pin_set_page_view_model.dart';

class SupplementaryDebitCardPinSetPage extends BasePage<SupplementaryDebitCardPinSetPageViewModel> {
  final SupplementaryDebitCardPinSetArguments _debitCardReplacementArguments;

  SupplementaryDebitCardPinSetPage(this._debitCardReplacementArguments);

  @override
  SupplementaryDebitCardPinSetPageState createState() => SupplementaryDebitCardPinSetPageState();
}

class SupplementaryDebitCardPinSetPageState
    extends BaseStatefulPage<SupplementaryDebitCardPinSetPageViewModel, SupplementaryDebitCardPinSetPage> {
  @override
  ProviderBase provideBase() {
    return suppDebitCardPinSetViewModelProvider;
  }

  @override
  void onModelReady(SupplementaryDebitCardPinSetPageViewModel model) {
    model.arguments = widget._debitCardReplacementArguments;
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, SupplementaryDebitCardPinSetPageViewModel model) {
    return SupplementaryDebitCardPinSetPageView(provideBase());
  }
}

class SupplementaryDebitCardPinSetArguments {
  final String nameOnCard;
  final String cardNo;
  final DebitReplacementEnum type;

  SupplementaryDebitCardPinSetArguments(
      {this.nameOnCard = "", this.cardNo = "", this.type = DebitReplacementEnum.Supplementary});
}
