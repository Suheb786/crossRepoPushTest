import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_two/register_step_two_page_view.dart';
import 'package:neo_bank/feature/register/step_two/register_step_two_page_view_model.dart';

class RegisterStepTwoPage extends BasePage<RegisterStepTwoViewModel> {
  @override
  RegisterStepTwoPageState createState() => RegisterStepTwoPageState();
}

class RegisterStepTwoPageState
    extends BaseStatefulPage<RegisterStepTwoViewModel, RegisterStepTwoPage> {
  @override
  ProviderBase provideBase() {
    return registerStepTwoViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, RegisterStepTwoViewModel model) {
    return RegisterStepTwoPageView(provideBase());
  }
}
