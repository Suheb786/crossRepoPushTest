import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_card_limits/manage_card_limits_modules.dart';
import 'package:neo_bank/feature/manage_credit_card_limits/manage_credit_card_limits_page_view.dart';
import 'package:neo_bank/feature/manage_credit_card_limits/manage_credit_card_limits_page_view_model.dart';

class ManageCreditCardLimitsPage
    extends BasePage<ManageCreditCardLimitsPageViewModel> {
  final ManageCreditCardLimitsArguments _cardLimitsArguments;

  ManageCreditCardLimitsPage(this._cardLimitsArguments);

  @override
  ManageCreditCardLimitsPageState createState() =>
      ManageCreditCardLimitsPageState();
}

class ManageCreditCardLimitsPageState extends BaseStatefulPage<
    ManageCreditCardLimitsPageViewModel, ManageCreditCardLimitsPage> {
  @override
  ProviderBase provideBase() {
    return manageCreditCardLimitsViewModelProvider
        .call(widget._cardLimitsArguments);
  }

  @override
  Widget buildView(
      BuildContext context, ManageCreditCardLimitsPageViewModel model) {
    return ManageCreditCardLimitsPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    Theme.of(context).primaryColor;
  }
}

class ManageCreditCardLimitsArguments {
  final String secureCode;
  final dynamic creditDeliveredDatetime;

  ManageCreditCardLimitsArguments(
      {this.secureCode: '', this.creditDeliveredDatetime});
}
