import 'package:domain/constants/enum/fatca_enum.dart';
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

class RegisterStepFourPageState extends BaseStatefulPage<RegisterStepFourViewModel, RegisterStepFourPage> {
  @override
  ProviderBase provideBase() {
    return registerStepFourViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  void onModelReady(RegisterStepFourViewModel model) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ProviderScope.containerOf(context).read(registerViewModelProvider).fatcaEnum != null) {
        switch (ProviderScope.containerOf(context).read(registerViewModelProvider).fatcaEnum) {
          case FatcaEnum.w8:
            Future.delayed(Duration(microseconds: 100), () {
              ProviderScope.containerOf(context).read(registerStepFourViewModelProvider).moveToPage(1);
            });
            break;
          case FatcaEnum.w9:
            Future.delayed(Duration(microseconds: 100), () {
              ProviderScope.containerOf(context).read(registerStepFourViewModelProvider).moveToPage(4);
            });
        }
      }
    });
  }

  @override
  Widget buildView(BuildContext context, RegisterStepFourViewModel model) {
    return RegisterStepFourPageView(provideBase());
  }
}
