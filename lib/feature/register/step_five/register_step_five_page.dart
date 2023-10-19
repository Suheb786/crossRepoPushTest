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

class RegisterStepFivePageState extends BaseStatefulPage<RegisterStepFiveViewModel, RegisterStepFivePage> {
  @override
  ProviderBase provideBase() {
    return registerStepFiveViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, RegisterStepFiveViewModel model) {
    return RegisterStepFivePageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(RegisterStepFiveViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(registerStepFiveViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
