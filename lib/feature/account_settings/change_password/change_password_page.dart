import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_password/change_password_page_view.dart';
import 'package:neo_bank/feature/account_settings/change_password/change_password_page_view_model.dart';

class ChangePasswordPage extends BasePage<ChangePasswordPageViewModel> {
  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState
    extends BaseStatefulPage<ChangePasswordPageViewModel, ChangePasswordPage> {
  @override
  ProviderBase provideBase() {
    return changePasswordViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ChangePasswordPageViewModel model) {
    return ChangePasswordPageView(provideBase());
  }
}
