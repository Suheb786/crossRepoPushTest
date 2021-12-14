import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/register_page_model.dart';
import 'package:neo_bank/feature/register/register_page_view.dart';

class RegisterPage extends BasePage<RegisterViewModel> {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState
    extends BaseStatefulPage<RegisterViewModel, RegisterPage> {
  @override
  ProviderBase provideBase() {
    return registerViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, RegisterViewModel model) {
    return RegisterPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}
