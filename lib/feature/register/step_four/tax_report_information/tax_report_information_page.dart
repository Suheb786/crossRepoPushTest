import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/tax_report_information/tax_report_information_page_view.dart';
import 'package:neo_bank/feature/register/step_four/tax_report_information/tax_report_information_page_view_model.dart';

class TaxReportInformationPage
    extends BasePage<TaxReportInformationPageViewModel> {
  @override
  TaxReportInformationPageState createState() =>
      TaxReportInformationPageState();
}

class TaxReportInformationPageState extends BaseStatefulPage<
    TaxReportInformationPageViewModel, TaxReportInformationPage> {
  @override
  ProviderBase provideBase() {
    return taxReportInformationPageViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, TaxReportInformationPageViewModel model) {
    return TaxReportInformationPageView(provideBase());
  }
}
