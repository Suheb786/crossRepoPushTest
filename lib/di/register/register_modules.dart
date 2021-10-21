import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/register/register_usecase_provider.dart';
import 'package:neo_bank/di/usecase/upload_document/upload_document_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/register/register_page_model.dart';
import 'package:neo_bank/feature/register/step_four/account_ready/account_ready_model.dart';
import 'package:neo_bank/feature/register/step_four/agent_selection/agent_selection_model.dart';
import 'package:neo_bank/feature/register/step_four/register_step_four_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/review_application/review_application_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/upload_documents/upload_documents_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/video_call_info/video_call_info_model.dart';
import 'package:neo_bank/feature/register/step_three/confirm_detail/confirm_detail_model.dart';
import 'package:neo_bank/feature/register/step_three/employment_status/employment_status_page_view_model.dart';
import 'package:neo_bank/feature/register/step_three/enter_address/enter_address_model.dart';
import 'package:neo_bank/feature/register/step_three/id_verification_info/id_verification_info_model.dart';
import 'package:neo_bank/feature/register/step_three/profile_details/profile_details_page_view_model.dart';
import 'package:neo_bank/feature/register/step_three/register_step_three_page_view_model.dart';
import 'package:neo_bank/feature/register/step_three/tax_report_information/tax_report_information_page_view_model.dart';
import 'package:neo_bank/feature/register/step_three/taxation_details/taxation_details_page_view_model.dart';
import 'package:neo_bank/feature/register/step_two/product_selector/product_selector_model.dart';
import 'package:neo_bank/feature/register/step_two/register_step_two_page_view_model.dart';
import 'package:neo_bank/feature/register/stepone/addnumber/add_number_model.dart';
import 'package:neo_bank/feature/register/stepone/countryselection/country_selection_model.dart';
import 'package:neo_bank/feature/register/stepone/createPassword/create_password_model.dart';
import 'package:neo_bank/feature/register/stepone/register_step_one_page_model.dart';
import 'package:neo_bank/feature/register/stepone/validateotp/validate_otp_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/additional_income_source/additional_income_source_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/employment_status/employment_status_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/home_address_dialog/home_address_dialog_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/nature_special_needs/nature_special_needs_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/occupation/occupation_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/purpose_of_account_opening/purpose_of_account_opening_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/reason_of_unavailability/reason_of_unavailability_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/relationship_with_pep/relationship_with_pep_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/profile/profile_item_view_model.dart';
import 'package:neo_bank/ui/molecules/register/taxation_switch_widget/taxation_switch_widget_model.dart';

final registerViewModelProvider =
    ChangeNotifierProvider.autoDispose<RegisterViewModel>(
  (ref) => RegisterViewModel(),
);

final registerStepOneViewModelProvider =
    ChangeNotifierProvider.autoDispose<RegisterStepOneViewModel>(
  (ref) => RegisterStepOneViewModel(),
);

final countrySelectionViewModelProvider =
    ChangeNotifierProvider.autoDispose<CountrySelectionViewModel>(
  (ref) => CountrySelectionViewModel(
    ref.read(fetchCountriesUseCaseProvider),
  ),
);

final addNumberViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddNumberViewModel>(
  (ref) => AddNumberViewModel(ref.read(registerNumberUseCaseProvider)),
);

///[ValidateOtpViewModel] provider
final validateOtpViewModelProvider =
    ChangeNotifierProvider.autoDispose<ValidateOtpViewModel>(
  (ref) => ValidateOtpViewModel(ref.read(verifyOtpUseCaseProvider)),
);

///[CreatePasswordViewModel] provider
final createPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreatePasswordViewModel>((ref) =>
        CreatePasswordViewModel(ref.read(createPasswordUseCaseProvider)));

///[IdVerificationInfoViewModel] provider
final idVerificationInfoViewModelProvider =
    ChangeNotifierProvider.autoDispose<IdVerificationInfoViewModel>((ref) =>
        IdVerificationInfoViewModel(
            ref.read(idVerificationInfoUseCaseProvider)));

///[ConfirmDetailViewModel] provider
final confirmDetailViewModelProvider =
    ChangeNotifierProvider.autoDispose<ConfirmDetailViewModel>((ref) =>
        ConfirmDetailViewModel(ref.read(confirmDetailUseCaseProvider)));

///[EnterAddressViewModel] provider
final enterAddressViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterAddressViewModel>(
        (ref) => EnterAddressViewModel(ref.read(enterAddressUseCaseProvider)));

///step two page view model provider
final registerStepTwoViewModelProvider =
    ChangeNotifierProvider.autoDispose<RegisterStepTwoViewModel>(
  (ref) => RegisterStepTwoViewModel(),
);

///step three page view model provider
final registerStepThreeViewModelProvider =
    ChangeNotifierProvider.autoDispose<RegisterStepThreeViewModel>(
  (ref) => RegisterStepThreeViewModel(),
);

///employment Status page view model provider
final employmentStatusPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<EmploymentStatusPageViewModel>(
  (ref) =>
      EmploymentStatusPageViewModel(ref.read(employmentDetailsUseCaseProvider)),
);

///employment status dialog view model provider
final employmentStatusDialogViwModelProvider =
    ChangeNotifierProvider.autoDispose<EmploymentStatusDialogViewModel>(
        (ref) => EmploymentStatusDialogViewModel());

///occupation dialog view model provider
final occupationDialogViwModelProvider =
    ChangeNotifierProvider.autoDispose<OccupationDialogViewModel>((ref) =>
        OccupationDialogViewModel(ref.read(getOccupationUseCaseProvider)));

///get purpose of account opening dialog view model provider
final purposeOfAccountOpeningDialogViwModelProvider =
    ChangeNotifierProvider.autoDispose<PurposeOfAccountOpeningDialogViewModel>(
        (ref) => PurposeOfAccountOpeningDialogViewModel(
            ref.read(purposeOfAccountOpeningUseCaseProvider)));

///get employer Country dialog view model provider
final employerCountryDialogViwModelProvider =
    ChangeNotifierProvider.autoDispose<CountryDialogViewModel>((ref) =>
        CountryDialogViewModel(ref.read(fetchCountriesUseCaseProvider)));

///additional income source dialog view model provider
final additionalIncomeSourceDialogViwModelProvider =
    ChangeNotifierProvider.autoDispose<AdditionIncomeSourceDialogViewModel>(
        (ref) => AdditionIncomeSourceDialogViewModel(
            ref.read(additionalIncomeSourceUseCaseProvider)));

///taxation details page view model provider
final taxationDetailsPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<TaxationDetailsPageViewModel>(
  (ref) =>
      TaxationDetailsPageViewModel(ref.read(taxationDetailsUseCaseProvider)),
);

final areYouUSCitizenViewModelProvider =
    ChangeNotifierProvider.autoDispose<TaxationSwitchWidgetViewModel>(
  (ref) => TaxationSwitchWidgetViewModel(),
);

final areYouUSTaxResidentViewModelProvider =
    ChangeNotifierProvider.autoDispose<TaxationSwitchWidgetViewModel>(
  (ref) => TaxationSwitchWidgetViewModel(),
);

final bornInUSViewModelProvider =
    ChangeNotifierProvider.autoDispose<TaxationSwitchWidgetViewModel>(
  (ref) => TaxationSwitchWidgetViewModel(),
);

final taxResidentOtherViewModelProvider =
    ChangeNotifierProvider.autoDispose<TaxationSwitchWidgetViewModel>(
  (ref) => TaxationSwitchWidgetViewModel(),
);

///tax report information page view model provider
final taxReportInformationPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<TaxReportInformationPageViewModel>(
  (ref) => TaxReportInformationPageViewModel(
      ref.read(taxReportInformationUseCaseProvider)),
);

final tinAvailableViewModelProvider =
    ChangeNotifierProvider.autoDispose<TaxationSwitchWidgetViewModel>(
  (ref) => TaxationSwitchWidgetViewModel(),
);

///reason of unavailability dialog view model provider
final reasonOfUnavailabilityDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<ReasonOfUnavailabilityDialogViewModel>(
  (ref) => ReasonOfUnavailabilityDialogViewModel(),
);

///profile details page view model provider
final profileDetailsPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ProfileDetailsPageViewModel>(
  (ref) => ProfileDetailsPageViewModel(ref.read(profileDetailsUseCaseProvider)),
);

final profileQ1ViewModelProvider =
    ChangeNotifierProvider.autoDispose<ProfileItemViewModel>(
  (ref) => ProfileItemViewModel(),
);

final profileQ2ViewModelProvider =
    ChangeNotifierProvider.autoDispose<ProfileItemViewModel>(
  (ref) => ProfileItemViewModel(),
);

final profileQ3ViewModelProvider =
    ChangeNotifierProvider.autoDispose<ProfileItemViewModel>(
  (ref) => ProfileItemViewModel(),
);

///employment status dialog view model provider
final natureSpecialNeedsDialogViwModelProvider =
    ChangeNotifierProvider.autoDispose<NatureSpecialNeedsDialogViewModel>(
        (ref) => NatureSpecialNeedsDialogViewModel(
            ref.read(natureOfSpecialNeedsUseCaseProvider)));

///relationship with pep dialog view model provider
final relationshipWithPEPDialogViwModelProvider =
    ChangeNotifierProvider.autoDispose<RelationshipWithPEPDialogViewModel>(
        (ref) => RelationshipWithPEPDialogViewModel(
            ref.read(relationshipWithPEPUseCaseProvider)));

///step four page view model provider
final registerStepFourViewModelProvider =
    ChangeNotifierProvider.autoDispose<RegisterStepFourViewModel>(
  (ref) => RegisterStepFourViewModel(),
);

///review application page
final reviewApplicationPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ReviewApplicationPageViewModel>(
  (ref) => ReviewApplicationPageViewModel(
      ref.read(reviewApplicationUseCaseProvider)),
);

///upload documents page
final uploadDocumentsPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<UploadDocumentsPageViewModel>(
  (ref) => UploadDocumentsPageViewModel(
      ref.read(sendDocumentsUseCaseUseCaseProvider),
      ref.read(uploadDocumentUseCaseProvider)),
);

///account ready page
final accountReadyPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<AccountReadyViewModel>(
  (ref) => AccountReadyViewModel(ref.read(accountReadyUseCaseProvider)),
);

///get home address dialog view model provider
final homeAddressDialogViwModelProvider =
    ChangeNotifierProvider.autoDispose<HomeAddressDialogViewModel>((ref) =>
        HomeAddressDialogViewModel(ref.read(homeAddressDialogUseCaseProvider)));

///product selector view model provider
final productSelectorViwModelProvider =
    ChangeNotifierProvider.autoDispose<ProductSelectorViewModel>((ref) =>
        ProductSelectorViewModel(ref.read(productSelectorUseCaseProvider)));

///video call info view model provider
final videoCallInfoViewModelProvider =
    ChangeNotifierProvider.autoDispose<VideoCallInfoViewModel>(
  (ref) => VideoCallInfoViewModel(ref.read(videoCallInfoUseCaseProvider)),
);

///agent selection view model provider
final agentSelectionViewModelProvider =
    ChangeNotifierProvider.autoDispose<AgentSelectionViewModel>(
  (ref) => AgentSelectionViewModel(ref.read(agentSelectionUseCaseProvider)),
);
