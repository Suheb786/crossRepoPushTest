import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/change_card_pin/change_card_pin_page.dart';
import 'package:neo_bank/feature/dashboard_home/card_unblock_pin_success/card_unblock_pin_success_page.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_view_model.dart';

class ManageCardPinPage extends BasePage<ManageCardPinViewModel> {
  final ManageCardPinArguments manageCardPinArguments;

  ManageCardPinPage({required this.manageCardPinArguments});

  @override
  ManageCardPinPageState createState() => ManageCardPinPageState();
}

class ManageCardPinPageState extends BaseStatefulPage<ManageCardPinViewModel, ManageCardPinPage> {
  @override
  ProviderBase provideBase() {
    return manageCardPinViewModelProvider.call(widget.manageCardPinArguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return getViewModel().manageCardPinArguments!.cardType == CardType.CREDIT
        ? Theme.of(context).primaryColor
        : Theme.of(context).canvasColor;
  }

  @override
  void onModelReady(ManageCardPinViewModel model) {
    ProviderScope.containerOf(context).read(appHomeViewModelProvider).changeCardPinArguments =
        ChangeCardPinArguments(
            cardType: model.manageCardPinArguments!.cardType,
            tokenizedPan: model.manageCardPinArguments!.tokenizedPan,
            cardNumber: model.manageCardPinArguments!.cardNumber);
  }

  @override
  Widget buildView(BuildContext context, ManageCardPinViewModel model) {
    return ManageCardPinPageView(provideBase());
  }
}

class ManageCardPinArguments {
  final CardType cardType;
  final String tokenizedPan;
  final FreezeCardStatusEnum freezeCardStatusEnum;
  final String cardNumber;
  final SuccessPageRouteEnum successPageRouteEnum;
  final bool isChangePinEnabled;

  ManageCardPinArguments(
      {this.cardType: CardType.CREDIT,
      this.tokenizedPan: "",
      this.cardNumber: "",
      this.freezeCardStatusEnum: FreezeCardStatusEnum.NONE,
      this.successPageRouteEnum = SuccessPageRouteEnum.UNBLOCK_DC,
      this.isChangePinEnabled = true});
}
