import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w8/fatca_us_relevant_w8_page_view.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w8/fatca_us_relevant_w8_page_view_model.dart';

class FatcaUSRelevantW8Page extends BasePage<FatcaUSRelevantW8PageViewModel> {
  @override
  FatcaUSRelevantW8PageState createState() => FatcaUSRelevantW8PageState();
}

class FatcaUSRelevantW8PageState extends BaseStatefulPage<
    FatcaUSRelevantW8PageViewModel, FatcaUSRelevantW8Page> {
  @override
  ProviderBase provideBase() {
    return fatcaUSRelevantW8PageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, FatcaUSRelevantW8PageViewModel model) {
    return FatcaUSRelevantW8PageView(provideBase());
  }
}
