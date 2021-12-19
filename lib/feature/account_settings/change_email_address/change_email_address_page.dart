import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/change_email_address_page_view.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/change_email_address_page_view_model.dart';

class ChangeEmailAddressPage extends BasePage<ChangeEmailAddressPageViewModel> {
  @override
  ChangeEmailAddressPageState createState() => ChangeEmailAddressPageState();
}

class ChangeEmailAddressPageState extends BaseStatefulPage<
    ChangeEmailAddressPageViewModel,
    ChangeEmailAddressPage> {
  @override
  ProviderBase provideBase() {
    return changeEmailAddressViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context,
      ChangeEmailAddressPageViewModel model) {
    return ChangeEmailAddressPageView(provideBase());
  }
}
