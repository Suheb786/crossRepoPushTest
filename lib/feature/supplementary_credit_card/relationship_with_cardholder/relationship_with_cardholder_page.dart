import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_credit_card/relationship_with_cardholder/relationship_with_cardholder_page_view.dart';
import 'package:neo_bank/feature/supplementary_credit_card/relationship_with_cardholder/relationship_with_cardholder_page_view_model.dart';

class RelationshipWithCardholderPage
    extends BasePage<RelationshipWithCardholderPageViewModel> {
  @override
  RelationshipWithCardholderPageState createState() =>
      RelationshipWithCardholderPageState();
}

class RelationshipWithCardholderPageState extends BaseStatefulPage<
    RelationshipWithCardholderPageViewModel, RelationshipWithCardholderPage> {
  @override
  ProviderBase provideBase() {
    return relationShipWithCardHolderViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, RelationshipWithCardholderPageViewModel model) {
    return RelationshipWithCardholderPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}
