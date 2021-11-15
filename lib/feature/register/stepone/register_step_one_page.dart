import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/register_step_one_page_model.dart';
import 'package:neo_bank/feature/register/stepone/register_step_one_page_view.dart';

class RegisterStepOnePage extends BasePage<RegisterStepOneViewModel> {
  @override
  RegisterStepOnePageState createState() => RegisterStepOnePageState();
}

class RegisterStepOnePageState
    extends BaseStatefulPage<RegisterStepOneViewModel, RegisterStepOnePage> {
  @override
  ProviderBase provideBase() {
    return registerStepOneViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, RegisterStepOneViewModel model) {
    return RegisterStepOnePageView(provideBase());
  }
}
