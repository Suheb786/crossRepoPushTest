import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/register_step_three_page_view.dart';
import 'package:neo_bank/feature/register/step_three/register_step_three_page_view_model.dart';

class RegisterStepThreePage extends BasePage<RegisterStepThreeViewModel> {
  @override
  RegisterStepThreePageState createState() => RegisterStepThreePageState();
}

class RegisterStepThreePageState extends BaseStatefulPage<RegisterStepThreeViewModel, RegisterStepThreePage> {
  @override
  ProviderBase provideBase() {
    return registerStepThreeViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, RegisterStepThreeViewModel model) {
    return RegisterStepThreePageView(provideBase());
  }
}
