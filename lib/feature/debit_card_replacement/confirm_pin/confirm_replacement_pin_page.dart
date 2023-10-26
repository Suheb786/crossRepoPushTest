import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement/confirm_pin/confirm_replacement_pin_page_view.dart';
import 'package:neo_bank/feature/debit_card_replacement/confirm_pin/confirm_replacement_pin_page_view_model.dart';

class ConfirmReplacementPinPage
    extends BasePage<ConfirmReplacementPinPageViewModel> {
  @override
  ConfirmReplacementPinPageState createState() =>
      ConfirmReplacementPinPageState();
}

class ConfirmReplacementPinPageState extends BaseStatefulPage<
    ConfirmReplacementPinPageViewModel, ConfirmReplacementPinPage> {
  @override
  ProviderBase provideBase() {
    return confirmReplacementPinViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(
      BuildContext context, ConfirmReplacementPinPageViewModel model) {
    return ConfirmReplacementPinPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(ConfirmReplacementPinPageViewModel model,
      {param}) async {
    var parentModel = ProviderScope.containerOf(context)
        .read(debitCardReplacementViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
