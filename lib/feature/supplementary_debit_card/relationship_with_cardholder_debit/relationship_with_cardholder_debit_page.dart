import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_debit_card/relationship_with_cardholder_debit/relationship_with_cardholder_debit_page_view.dart';
import 'package:neo_bank/feature/supplementary_debit_card/relationship_with_cardholder_debit/relationship_with_cardholder_debit_page_view_model.dart';

class RelationshipWithCardholderDebitPage
    extends BasePage<RelationshipWithCardholderDebitPageViewModel> {
  @override
  RelationshipWithCardholderDebitPageState createState() =>
      RelationshipWithCardholderDebitPageState();
}

class RelationshipWithCardholderDebitPageState extends BaseStatefulPage<
    RelationshipWithCardholderDebitPageViewModel,
    RelationshipWithCardholderDebitPage> with AutomaticKeepAliveClientMixin {
  RelationshipWithCardholderDebitPageState()
      : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return relationShipWithCardHolderDebitViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context,
      RelationshipWithCardholderDebitPageViewModel model) {
    return RelationshipWithCardholderDebitPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
