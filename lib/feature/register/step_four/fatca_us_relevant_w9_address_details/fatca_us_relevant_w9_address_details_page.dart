import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w9_address_details/fatca_us_relevant_w9_address_details_page_view.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w9_address_details/fatca_us_relevant_w9_address_details_page_view_model.dart';

class FatcaUSRelevantW9AddressDetailsPage
    extends BasePage<FatcaUSRelevantW9AddressDetailsPageViewModel> {
  @override
  FatcaUSRelevantW9AddressDetailsPageState createState() =>
      FatcaUSRelevantW9AddressDetailsPageState();
}

class FatcaUSRelevantW9AddressDetailsPageState extends BaseStatefulPage<
    FatcaUSRelevantW9AddressDetailsPageViewModel,
    FatcaUSRelevantW9AddressDetailsPage>
    with AutomaticKeepAliveClientMixin {
  FatcaUSRelevantW9AddressDetailsPageState()
      : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return fatcaUSRelevantW9AddressPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme
        .of(context)
        .primaryColor;
  }

  @override
  Widget buildView(BuildContext context,
      FatcaUSRelevantW9AddressDetailsPageViewModel model) {
    return FatcaUSRelevantW9AddressDetailsPageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
