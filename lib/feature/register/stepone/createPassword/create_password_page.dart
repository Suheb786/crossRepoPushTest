import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/createPassword/create_password_model.dart';
import 'package:neo_bank/feature/register/stepone/createPassword/create_password_view.dart';

class CreatePasswordPage extends BasePage<CreatePasswordViewModel> {
  @override
  CreatePasswordPageState createState() => CreatePasswordPageState();
}

class CreatePasswordPageState
    extends BaseStatefulPage<CreatePasswordViewModel, CreatePasswordPage> {
  @override
  ProviderBase provideBase() {
    return createPasswordViewModelProvider;
  }

  @override
  void onModelReady(CreatePasswordViewModel model) {
  }

  @override
  Widget buildView(BuildContext context, CreatePasswordViewModel model) {
    return CreatePasswordView(provideBase());
  }
}