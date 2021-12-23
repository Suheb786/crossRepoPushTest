import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w8_tax_payer_details/fatca_us_w8_tax_payer_details_page_view.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w8_tax_payer_details/fatca_us_w8_tax_payer_details_page_view_model.dart';

class FatcaUSW8TaxPayersDetailsPage
    extends BasePage<FatcaUSW8TaxPayersDetailsPageViewModel> {
  @override
  FatcaUSW8TaxPayersDetailsPageState createState() =>
      FatcaUSW8TaxPayersDetailsPageState();
}

class FatcaUSW8TaxPayersDetailsPageState extends BaseStatefulPage<
    FatcaUSW8TaxPayersDetailsPageViewModel,
    FatcaUSW8TaxPayersDetailsPage>
    with AutomaticKeepAliveClientMixin {
  FatcaUSW8TaxPayersDetailsPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return fatcaUSW8TaxPayerDetailsPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme
        .of(context)
        .primaryColor;
  }

  @override
  Widget buildView(BuildContext context,
      FatcaUSW8TaxPayersDetailsPageViewModel model) {
    return FatcaUSW8TaxPayersDetailsPageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
