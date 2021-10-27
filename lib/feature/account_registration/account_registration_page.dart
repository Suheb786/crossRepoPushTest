import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';

class AccountRegistrationPage
    extends BasePage<AccountRegistrationPageViewModel> {
  @override
  AccountRegistrationPageState createState() => AccountRegistrationPageState();
}

class AccountRegistrationPageState extends BaseStatefulPage<
    AccountRegistrationPageViewModel, AccountRegistrationPage> {
  @override
  ProviderBase provideBase() {
    return accountRegistrationViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, AccountRegistrationPageViewModel model) {
    return AccountRegistrationPageView(provideBase());
  }
}
