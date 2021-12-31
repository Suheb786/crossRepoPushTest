import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_view_model.dart';

class ManageCardPinPage extends BasePage<ManageCardPinViewModel> {
  final ManageCardPinArguments manageCardPinArguments;

  ManageCardPinPage({required this.manageCardPinArguments});

  @override
  ManageCardPinPageState createState() => ManageCardPinPageState();
}

class ManageCardPinPageState
    extends BaseStatefulPage<ManageCardPinViewModel, ManageCardPinPage> {
  @override
  ProviderBase provideBase() {
    return manageCardPinViewModelProvider.call(widget.manageCardPinArguments!);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return getViewModel().manageCardPinArguments!.cardType == CardType.CREDIT
        ? Theme.of(context).primaryColor
        : Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(BuildContext context, ManageCardPinViewModel model) {
    return ManageCardPinPageView(provideBase());
  }
}

class ManageCardPinArguments {
  final CardType cardType;

  ManageCardPinArguments({this.cardType: CardType.CREDIT});
}
