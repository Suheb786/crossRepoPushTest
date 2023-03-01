import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_credit_card/id_scan_verification_info/supplementary_id_scan_verification_info_page_view.dart';
import 'package:neo_bank/feature/supplementary_credit_card/id_scan_verification_info/supplementary_id_scan_verification_info_page_view_model.dart';

class SupplementaryIdScanVerificationInfoPage
    extends BasePage<SupplementaryIdScanVerificationInfoPageViewModel> {
  @override
  SupplementaryIdScanVerificationInfoPageState createState() =>
      SupplementaryIdScanVerificationInfoPageState();
}

class SupplementaryIdScanVerificationInfoPageState extends BaseStatefulPage<
    SupplementaryIdScanVerificationInfoPageViewModel, SupplementaryIdScanVerificationInfoPage> {
  @override
  ProviderBase provideBase() {
    return supplementaryIdScanInfoViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, SupplementaryIdScanVerificationInfoPageViewModel model) {
    return SupplementaryIdScanVerificationInfoPageView(provideBase());
  }
}
