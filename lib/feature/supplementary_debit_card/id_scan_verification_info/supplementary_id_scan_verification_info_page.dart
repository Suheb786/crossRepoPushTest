import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_debit_card/id_scan_verification_info/supplementary_id_scan_verification_info_page_view.dart';
import 'package:neo_bank/feature/supplementary_debit_card/id_scan_verification_info/supplementary_id_scan_verification_info_page_view_model.dart';

class SupplementaryIdScanVerificationInfoDebitPage
    extends BasePage<SupplementaryIdScanVerificationInfoDebitPageViewModel> {
  @override
  SupplementaryIdScanVerificationInfoDebitPageState createState() =>
      SupplementaryIdScanVerificationInfoDebitPageState();
}

class SupplementaryIdScanVerificationInfoDebitPageState
    extends BaseStatefulPage<
        SupplementaryIdScanVerificationInfoDebitPageViewModel,
        SupplementaryIdScanVerificationInfoDebitPage> {
  @override
  ProviderBase provideBase() {
    return supplementaryDebitIdScanInfoViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(BuildContext context,
      SupplementaryIdScanVerificationInfoDebitPageViewModel model) {
    return SupplementaryIdScanVerificationInfoDebitPageView(provideBase());
  }
}
