import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/non_jordanian_register/non_jordanian_register_modules.dart';
import 'package:neo_bank/feature/non_jordanian_register/non_jordanian_register_page_view.dart';
import 'package:neo_bank/feature/non_jordanian_register/non_jordanian_register_page_view_model.dart';

class NonJordanianRegistrationPage extends BasePage<NonJordanianRegisterPageViewModel> {
  @override
  NonJordanianRegistrationPageState createState() => NonJordanianRegistrationPageState();
}

class NonJordanianRegistrationPageState
    extends BaseStatefulPage<NonJordanianRegisterPageViewModel, NonJordanianRegistrationPage> {
  @override
  ProviderBase provideBase() {
    return nonJordanianRegistrationViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, NonJordanianRegisterPageViewModel model) {
    return NonJordanianRegisterPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Future<bool> onBackPressed(NonJordanianRegisterPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(nonJordanianRegistrationViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
