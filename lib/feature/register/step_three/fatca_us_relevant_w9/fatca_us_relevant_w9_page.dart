import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/fatca_us_relevant_w9/fatca_us_relevant_w9_page_view.dart';
import 'package:neo_bank/feature/register/step_three/fatca_us_relevant_w9/fatca_us_relevant_w9_page_view_model.dart';

class FatcaUSRelevantW9Page extends BasePage<FatcaUSRelevantW9PageViewModel> {
  @override
  FatcaUSRelevantW9PageState createState() => FatcaUSRelevantW9PageState();
}

class FatcaUSRelevantW9PageState extends BaseStatefulPage<
    FatcaUSRelevantW9PageViewModel, FatcaUSRelevantW9Page> {
  @override
  ProviderBase provideBase() {
    return fatcaUSRelevantW9PageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, FatcaUSRelevantW9PageViewModel model) {
    return FatcaUSRelevantW9PageView(provideBase());
  }
}
