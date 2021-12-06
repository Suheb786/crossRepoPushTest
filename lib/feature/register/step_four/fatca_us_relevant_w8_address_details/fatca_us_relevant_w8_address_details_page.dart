import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w8_address_details/fatca_us_relevant_w8_address_details_page_view.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w8_address_details/fatca_us_relevant_w8_address_details_page_view_model.dart';

class FatcaUSRelevantW8AddressDetailsPage
    extends BasePage<FatcaUSRelevantW8AddressDetailsPageViewModel> {
  @override
  FatcaUSRelevantW8AddressDetailsPageState createState() =>
      FatcaUSRelevantW8AddressDetailsPageState();
}

class FatcaUSRelevantW8AddressDetailsPageState extends BaseStatefulPage<
    FatcaUSRelevantW8AddressDetailsPageViewModel,
    FatcaUSRelevantW8AddressDetailsPage> with AutomaticKeepAliveClientMixin {
  FatcaUSRelevantW8AddressDetailsPageState()
      : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return fatcaUSRelevantW8AddressPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context,
      FatcaUSRelevantW8AddressDetailsPageViewModel model) {
    return FatcaUSRelevantW8AddressDetailsPageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
