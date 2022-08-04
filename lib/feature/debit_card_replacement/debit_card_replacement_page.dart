import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page_view.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page_view_model.dart';
import 'package:neo_bank/ui/molecules/card/apply_debit_card_widget.dart';

class DebitCardReplacementPage extends BasePage<DebitCardReplacementPageViewModel> {
  final DebitCardReplacementArguments _debitCardReplacementArguments;

  DebitCardReplacementPage(this._debitCardReplacementArguments);

  @override
  DebitCardReplacementPageState createState() => DebitCardReplacementPageState();
}

class DebitCardReplacementPageState
    extends BaseStatefulPage<DebitCardReplacementPageViewModel, DebitCardReplacementPage> {
  @override
  ProviderBase provideBase() {
    return debitCardReplacementViewModelProvider;
  }

  @override
  void onModelReady(DebitCardReplacementPageViewModel model) {
    super.onModelReady(model);
    if (widget._debitCardReplacementArguments != null) {
      model.debitCardReplacementArguments = widget._debitCardReplacementArguments;
      if (widget._debitCardReplacementArguments.isPinSet) {
        Future.delayed(Duration(microseconds: 100), () {
          model.navigateToPage(0);
        });
      } else {
        Future.delayed(Duration(microseconds: 100), () {
          model.moveToPage(1);
        });
      }
    }
  }

  @override
  Widget buildView(BuildContext context, DebitCardReplacementPageViewModel model) {
    return DebitCardReplacementPageView(provideBase());
  }
}

class DebitCardReplacementArguments {
  final bool isPinSet;
  final DebitReplacementEnum type;
  final DebitRoutes debitRoutes;

  DebitCardReplacementArguments(
      {this.isPinSet: true,
      this.type: DebitReplacementEnum.Normal,
      this.debitRoutes = DebitRoutes.DASHBOARD});
}

enum DebitReplacementEnum { Normal, Supplementary }
