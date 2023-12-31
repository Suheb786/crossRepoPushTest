import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/onboarding/onboarding_module.dart';
import 'package:neo_bank/di/registerselection/onboarding_module.dart';
import 'package:neo_bank/feature/onboarding/registerselection/register_selection_page_model.dart';
import 'package:neo_bank/feature/onboarding/registerselection/register_selection_page_view.dart';

class RegisterSelectionPage extends BasePage<RegisterSelectionViewModel> {
  @override
  RegisterSelectionPageState createState() => RegisterSelectionPageState();
}

class RegisterSelectionPageState extends BaseStatefulPage<RegisterSelectionViewModel, RegisterSelectionPage> {
  @override
  ProviderBase provideBase() {
    return registerSelectionViewModelProvider;
  }

  @override
  Future<bool> onBackPressed(RegisterSelectionViewModel model, {param}) async {
    ProviderScope.containerOf(context)
        .read(onBoardingViewModelProvider)
        .onBoardingPageController
        .previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    return false;
  }

  @override
  Widget buildView(BuildContext context, RegisterSelectionViewModel model) {
    return RegisterSelectionPageView(provideBase());
  }
}
