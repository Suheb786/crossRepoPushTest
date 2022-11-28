import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/static_content/claim_of_tax_treaty_benefits/claim_of_tax_treaty_benefits_page.dart';
import 'package:neo_bank/feature/static_content/claim_of_tax_treaty_benefits/claim_of_tax_treaty_benefits_page_view_model.dart';
import 'package:neo_bank/feature/static_content/exempt_payee_code/exempt_payee_code_page_view_model.dart';
import 'package:neo_bank/feature/static_content/exemption_from_fatca_reporting_code/exemption_from_fatca_reporting_code_page_view_model.dart';
import 'package:neo_bank/feature/static_content/fatca_certification/fatca_certification_page_view_model.dart';
import 'package:neo_bank/feature/static_content/reference_number/reference_number_page_view-model.dart';
import 'package:neo_bank/feature/static_content/us_tax_payer_identification_number/us_tax_payer_identification_number_page_view_model.dart';

///fatca view model provider
final fatcaCertificationViewModelProvider =
    ChangeNotifierProvider.autoDispose<FatcaCertificationPageViewModel>(
  (ref) => FatcaCertificationPageViewModel(),
);

///exempt payee code page view model provider
final exemptPayeeCodeViewModelProvider = ChangeNotifierProvider.autoDispose<ExemptPayeeCodePageViewModel>(
  (ref) => ExemptPayeeCodePageViewModel(),
);

///exempt from fatca reporting code page view model provider
final exemptionFromFatcaReportingCodeViewModelProvider =
    ChangeNotifierProvider.autoDispose<ExemptionFromFatcaReportingCodePageViewModel>(
  (ref) => ExemptionFromFatcaReportingCodePageViewModel(),
);

///us taxpayer identification number page view model provider
final usTaxPayerIdentificationNumberViewModelProvider =
    ChangeNotifierProvider.autoDispose<UsTaxPayerIdentificationNumberPageViewModel>(
  (ref) => UsTaxPayerIdentificationNumberPageViewModel(),
);

///reference Number page view model provider
final referenceNumberViewModelProvider = ChangeNotifierProvider.autoDispose<ReferenceNumberPageViewModel>(
  (ref) => ReferenceNumberPageViewModel(),
);

///tax treaty benefits page view model provider
final claimOfTaxTreatyBenefitsViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<ClaimOfTaxTreatyBenefitsPageViewModel, ClaimOfTaxTreatyBenefitsArguments>(
  (ref, args) => ClaimOfTaxTreatyBenefitsPageViewModel(args),
);
