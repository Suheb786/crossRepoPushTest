import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/forgot_password/forgot_password_modules.dart';
import 'package:neo_bank/feature/forgot_password/add_id_number_for_reset_password/add_id_number_for_reset_password_page_view.dart';
import 'package:neo_bank/feature/forgot_password/add_id_number_for_reset_password/add_id_number_for_reset_password_page_view_model.dart';

class AddIDNumberForResetPasswordPage
    extends BasePage<AddIDNumberForResetPasswordPageViewModel> {
  @override
  AddIDNumberForResetPasswordPageState createState() =>
      AddIDNumberForResetPasswordPageState();
}

class AddIDNumberForResetPasswordPageState extends BaseStatefulPage<
    AddIDNumberForResetPasswordPageViewModel, AddIDNumberForResetPasswordPage> {
  @override
  ProviderBase provideBase() {
    return addIdNumberForResetPasswordViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(
      BuildContext context, AddIDNumberForResetPasswordPageViewModel model) {
    return AddIDNumberForResetPasswordPageView(provideBase());
  }
}
