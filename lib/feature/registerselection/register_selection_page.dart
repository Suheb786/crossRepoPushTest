import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/registerselection/onboarding_module.dart';
import 'package:neo_bank/feature/registerselection/register_selection_page_model.dart';
import 'package:neo_bank/feature/registerselection/register_selection_page_view.dart';
import 'package:neo_bank/utils/color_utils.dart';

class RegisterSelectionPage extends BasePage<RegisterSelectionViewModel> {
  @override
  RegisterSelectionPageState createState() => RegisterSelectionPageState();
}

class RegisterSelectionPageState extends BaseStatefulPage<
    RegisterSelectionViewModel, RegisterSelectionPage> {
  @override
  ProviderBase provideBase() {
    return registerSelectionViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() {
    return AppColor.white;
  }

  @override
  Widget buildView(BuildContext context, RegisterSelectionViewModel model) {
    return RegisterSelectionPageView(provideBase());
  }
}
