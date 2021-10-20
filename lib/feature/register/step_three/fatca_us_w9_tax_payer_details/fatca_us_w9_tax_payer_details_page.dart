import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/fatca_us_w9_tax_payer_details/fatca_us_w9_tax_payer_details_page_view.dart';
import 'package:neo_bank/feature/register/step_three/fatca_us_w9_tax_payer_details/fatca_us_w9_tax_payer_details_page_view_model.dart';

class FatcaUSW9TaxPayersDetailsPage
    extends BasePage<FatcaUSW9TaxPayersDetailsPageViewModel> {
  @override
  FatcaUSW9TaxPayersDetailsPageState createState() =>
      FatcaUSW9TaxPayersDetailsPageState();
}

class FatcaUSW9TaxPayersDetailsPageState extends BaseStatefulPage<
    FatcaUSW9TaxPayersDetailsPageViewModel, FatcaUSW9TaxPayersDetailsPage> {
  @override
  ProviderBase provideBase() {
    return fatcaUSW9TaxPayerDetailsPageViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, FatcaUSW9TaxPayersDetailsPageViewModel model) {
    return FatcaUSW9TaxPayersDetailsPageView(provideBase());
  }
}
