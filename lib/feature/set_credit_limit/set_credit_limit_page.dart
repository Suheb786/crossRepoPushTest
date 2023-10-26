import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/apply_credit_card/apply_credit_card_modules.dart';
import 'package:neo_bank/feature/set_credit_limit/set_credit_limit_page_view.dart';
import 'package:neo_bank/feature/set_credit_limit/set_credit_limit_view_model.dart';

class SetCreditLimitPage extends BasePage<SetCreditLimitViewModel> {
  @override
  SetCreditLimitPageState createState() => SetCreditLimitPageState();
}

class SetCreditLimitPageState
    extends BaseStatefulPage<SetCreditLimitViewModel, SetCreditLimitPage> {
  @override
  ProviderBase provideBase() {
    return setCreditLimitViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, SetCreditLimitViewModel model) {
    return SetCreditLimitPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Future<bool> onBackPressed(SetCreditLimitViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context)
        .read(applyCreditCardHomeViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
