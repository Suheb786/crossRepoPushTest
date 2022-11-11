import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/selected_card_for_apple_pay/selected_card_for_apple_pay_modules.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_page_view.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class SelectedCardForApplePayPage extends BasePage<SelectedCardForApplePayPageViewModel> {
  @override
  SelectedCardForApplePayPageState createState() => SelectedCardForApplePayPageState();
}

class SelectedCardForApplePayPageState
    extends BaseStatefulPage<SelectedCardForApplePayPageViewModel, SelectedCardForApplePayPage> {
  @override
  ProviderBase provideBase() {
    return selectedCardForApplePayPageViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(preferredSize: Size(double.maxFinite, 96.h), child: Container());
  }

  @override
  void onModelReady(SelectedCardForApplePayPageViewModel model) {
    model.list = [
      CardTypeData(
          S.of(context).creditCard, AssetUtils.creditCardRedSmall, S.of(context).rebelliousRedCreditCard),
      CardTypeData(
          S.of(context).debitCard, AssetUtils.debitCardYellowSmall, S.of(context).yellowSunDebitCard),
    ];
  }

  @override
  Widget buildView(BuildContext context, SelectedCardForApplePayPageViewModel model) {
    return SelectedCardForApplePayPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}
