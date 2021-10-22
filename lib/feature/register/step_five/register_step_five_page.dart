import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/register_step_five_page_view.dart';
import 'package:neo_bank/feature/register/step_five/register_step_five_page_view_model.dart';

class RegisterStepFivePage extends BasePage<RegisterStepFiveViewModel> {
  @override
  RegisterStepFivePageState createState() => RegisterStepFivePageState();
}

class RegisterStepFivePageState
    extends BaseStatefulPage<RegisterStepFiveViewModel, RegisterStepFivePage> {
  @override
  ProviderBase provideBase() {
    return registerStepFiveViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, RegisterStepFiveViewModel model) {
    return RegisterStepFivePageView(provideBase());
  }
}
