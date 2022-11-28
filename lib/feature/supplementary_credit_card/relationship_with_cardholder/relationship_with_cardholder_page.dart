import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_credit_card/relationship_with_cardholder/relationship_with_cardholder_page_view.dart';
import 'package:neo_bank/feature/supplementary_credit_card/relationship_with_cardholder/relationship_with_cardholder_page_view_model.dart';

class RelationshipWithCardholderPage extends BasePage<RelationshipWithCardholderPageViewModel> {
  @override
  RelationshipWithCardholderPageState createState() => RelationshipWithCardholderPageState();
}

class RelationshipWithCardholderPageState
    extends BaseStatefulPage<RelationshipWithCardholderPageViewModel, RelationshipWithCardholderPage>
    with AutomaticKeepAliveClientMixin {
  @override
  ProviderBase provideBase() {
    return relationShipWithCardHolderViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, RelationshipWithCardholderPageViewModel model) {
    return RelationshipWithCardholderPageView(provideBase());
  }

  @override
  void onModelReady(RelationshipWithCardholderPageViewModel model) {
    model.getCreditCardRelationship(
        cardId: ProviderScope.containerOf(context)
                .read(supplementaryCreditCardViewModelProvider)
                .creditCard
                .cardId ??
            '');
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
