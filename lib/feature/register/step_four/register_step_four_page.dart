import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/register_step_four_page_view.dart';
import 'package:neo_bank/feature/register/step_four/register_step_four_page_view_model.dart';

class RegisterStepFourPage extends BasePage<RegisterStepFourViewModel> {
  @override
  RegisterStepFourPageState createState() => RegisterStepFourPageState();
}

class RegisterStepFourPageState
    extends BaseStatefulPage<RegisterStepFourViewModel, RegisterStepFourPage> {
  @override
  ProviderBase provideBase() {
    return registerStepFourViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, RegisterStepFourViewModel model) {
    return RegisterStepFourPageView(provideBase());
  }
}
