import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_card_in_review/supplementary_card_in_review_page_view.dart';
import 'package:neo_bank/feature/supplementary_card_in_review/supplementary_card_in_review_page_view_model.dart';

class SupplementaryCardInReviewPage extends BasePage<SupplementaryCardInReviewPageViewModel> {
  final SupplementaryCardInReviewArguments _arguments;

  SupplementaryCardInReviewPage(this._arguments);

  @override
  SupplementaryCardInReviewPageState createState() => SupplementaryCardInReviewPageState();
}

class SupplementaryCardInReviewPageState
    extends BaseStatefulPage<SupplementaryCardInReviewPageViewModel, SupplementaryCardInReviewPage> {
  @override
  ProviderBase provideBase() {
    return supplementaryCardInReviewViewModelProvider.call(widget._arguments);
  }

  @override
  Widget buildView(BuildContext context, SupplementaryCardInReviewPageViewModel model) {
    return SupplementaryCardInReviewPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return getViewModel().cardInReviewArguments.cardType == CardType.DEBIT
        ? Theme.of(context).canvasColor
        : Theme.of(context).primaryColor;
  }
}

class SupplementaryCardInReviewArguments {
  final CardType cardType;

  SupplementaryCardInReviewArguments({required this.cardType});
}
