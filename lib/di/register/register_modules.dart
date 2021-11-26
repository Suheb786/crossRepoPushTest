import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/account/account_usecase_provider.dart';
import 'package:neo_bank/di/usecase/account_registration/account_regisration_usecase_provider.dart';
import 'package:neo_bank/di/usecase/bank_smart/bank_smart_usecase_provider.dart';
import 'package:neo_bank/di/usecase/fatca_crs/fatca_crs_usecase_provider.dart';
import 'package:neo_bank/di/usecase/register/register_usecase_provider.dart';
import 'package:neo_bank/di/usecase/upload_document/upload_document_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/register/register_page_model.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_model.dart';
import 'package:neo_bank/feature/register/step_five/agent_selection/agent_selection_model.dart';
import 'package:neo_bank/feature/register/step_five/register_step_five_page_view_model.dart';
import 'package:neo_bank/feature/register/step_five/review_application/review_application_page_view_model.dart';
import 'package:neo_bank/feature/register/step_five/schedule_video_call/schedule_video_call_page_view_model.dart';
import 'package:neo_bank/feature/register/step_five/upload_documents/upload_documents_page_view_model.dart';
import 'package:neo_bank/feature/register/step_five/video_call_info/video_call_info_model.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w8/fatca_us_relevant_w8_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w8_address_details/fatca_us_relevant_w8_address_details_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w9/fatca_us_relevant_w9_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w9_address_details/fatca_us_relevant_w9_address_details_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w8_tax_payer_details/fatca_us_w8_tax_payer_details_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w9_tax_payer_details/fatca_us_w9_tax_payer_details_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/register_step_four_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/tax_report_information/tax_report_information_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/taxation_details/taxation_details_page_view_model.dart';
import 'package:neo_bank/feature/register/step_three/purpose_of_account_opening/purpose_of_account_opening_page_view_model.dart';
import 'package:neo_bank/feature/register/step_three/register_step_three_page_view_model.dart';
import 'package:neo_bank/feature/register/step_two/job_and_income/job_and_income_page_view_model.dart';
import 'package:neo_bank/feature/register/step_two/register_step_two_page_view_model.dart';
import 'package:neo_bank/feature/register/step_two/student_job_income/student_job_income_page_view_model.dart';
import 'package:neo_bank/feature/register/stepone/confirm_detail/confirm_detail_model.dart';
import 'package:neo_bank/feature/register/stepone/enter_address/enter_address_model.dart';
import 'package:neo_bank/feature/register/stepone/id_verification_info/id_verification_info_model.dart';
import 'package:neo_bank/feature/register/stepone/profile_details/profile_details_page_view_model.dart';
import 'package:neo_bank/feature/register/stepone/register_step_one_page_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/tax_payer/tax_payer_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/calendar_dialog/calendar_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/year_month_dialog/year_month_dialog_view_model.dart';
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

///[IdVerificationInfoViewModel] provider
final idVerificationInfoViewModelProvider =
    ChangeNotifierProvider.autoDispose<IdVerificationInfoViewModel>((ref) =>
        IdVerificationInfoViewModel(ref.read(idVerificationInfoUseCaseProvider),
            ref.read(scanUserDocumentUseCaseProvider)));

///[ConfirmDetailViewModel] provider
final confirmDetailViewModelProvider =
    ChangeNotifierProvider.autoDispose<ConfirmDetailViewModel>((ref) =>
        ConfirmDetailViewModel(ref.read(confirmDetailUseCaseProvider),
            ref.read(scanUserDocumentUseCaseProvider)));

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

///job and income page view model provider
final jobAndIncomePageViewModelProvider =
    ChangeNotifierProvider.autoDispose<JobAndIncomePageViewModel>(
  (ref) => JobAndIncomePageViewModel(ref.read(jobAndIncomeUseCaseProvider)),
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
  (ref) => TaxationDetailsPageViewModel(
      ref.read(setFatcaQuestionsResponseUseCaseProvider),
      ref.read(getFatcaQuestionsUseCaseProvider)),
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

final areYouFirstDegreeRelativeViewModelProvider =
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

final areYouBeneficialOwnerAccountProvider =
    ChangeNotifierProvider.autoDispose<ProfileItemViewModel>(
  (ref) => ProfileItemViewModel(),
);

final profileQ3ViewModelProvider =
    ChangeNotifierProvider.autoDispose<ProfileItemViewModel>(
  (ref) => ProfileItemViewModel(),
);

final studentIncomeViewModelProvider =
    ChangeNotifierProvider.autoDispose<ProfileItemViewModel>(
  (ref) => ProfileItemViewModel(),
);

final anyOtherNationalityViewModelProvider =
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
      ref.read(reviewApplicationUseCaseProvider),
      ref.read(checkVideoCallStatusUseCaseProvider),
      ref.read(getAccountUseCaseProvider),
      ref.read(createAccountUseCaseProvider),
      ref.read(getConfirmApplicationDataUseCaseProvider)),
);

///upload documents page
final uploadDocumentsPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<UploadDocumentsPageViewModel>(
  (ref) => UploadDocumentsPageViewModel(
      ref.read(sendDocumentsUseCaseUseCaseProvider),
      ref.read(uploadDocumentUseCaseProvider),
      ref.read(checkOtherNationalityStatusUseCaseProvider),
      ref.read(fileUploadUseCaseProvider)),
);

///account ready page
final accountReadyPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<AccountReadyViewModel>(
  (ref) => AccountReadyViewModel(ref.read(accountReadyUseCaseProvider)),
);

/// purpose of account opening  view model provider
final purposeOfAccountOpeningViewModelProvider =
    ChangeNotifierProvider.autoDispose<PurposeOfAccountOpeningPageViewModel>(
        (ref) => PurposeOfAccountOpeningPageViewModel(
            ref.read(purposeOfAccountsOpeningUseCaseProvider)));

///fatca us relevant w8 page view model provider
final fatcaUSRelevantW8PageViewModelProvider =
    ChangeNotifierProvider.autoDispose<FatcaUSRelevantW8PageViewModel>(
  (ref) => FatcaUSRelevantW8PageViewModel(
      ref.read(fatcaUSRelevantW8UseCaseProvider)),
);

///fatca us relevant w8 address details page view model provider
final fatcaUSRelevantW8AddressPageViewModelProvider = ChangeNotifierProvider
    .autoDispose<FatcaUSRelevantW8AddressDetailsPageViewModel>(
  (ref) => FatcaUSRelevantW8AddressDetailsPageViewModel(
      ref.read(fatcaUSRelevantW8AddressDetailsUseCaseProvider)),
);

///fatca us relevant w9 page view model provider
final fatcaUSRelevantW9PageViewModelProvider =
    ChangeNotifierProvider.autoDispose<FatcaUSRelevantW9PageViewModel>(
  (ref) => FatcaUSRelevantW9PageViewModel(
      ref.read(fatcaUSRelevantW9UseCaseProvider)),
);

///fatca us relevant w9 address details page view model provider
final fatcaUSRelevantW9AddressPageViewModelProvider = ChangeNotifierProvider
    .autoDispose<FatcaUSRelevantW9AddressDetailsPageViewModel>(
  (ref) => FatcaUSRelevantW9AddressDetailsPageViewModel(
      ref.read(fatcaUSRelevantW9AddressDetailsUseCaseProvider)),
);

///fatca us w9 tax payer details page view model provider
final fatcaUSW9TaxPayerDetailsPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<FatcaUSW9TaxPayersDetailsPageViewModel>(
  (ref) => FatcaUSW9TaxPayersDetailsPageViewModel(
      ref.read(fatcaUSW9TaxPayerDetailsUseCaseProvider),
      ref.read(uploadDocumentUseCaseProvider)),
);

///tax payer dialog view model provider
final taxPayerDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<TaxPayerDialogViewModel>(
        (ref) => TaxPayerDialogViewModel());

///fatca us w8 tax payer details page view model provider
final fatcaUSW8TaxPayerDetailsPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<FatcaUSW8TaxPayersDetailsPageViewModel>(
  (ref) => FatcaUSW8TaxPayersDetailsPageViewModel(
      ref.read(fatcaUSW8TaxPayerDetailsUseCaseProvider)),
);

///schedule video call page view model provider
final scheduleVideoCallPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ScheduleVideoCallPageViewModel>(
  (ref) => ScheduleVideoCallPageViewModel(
      ref.read(scheduleVideoCallUseCaseProvider)),
);

///get home address dialog view model provider
final homeAddressDialogViwModelProvider =
    ChangeNotifierProvider.autoDispose<HomeAddressDialogViewModel>((ref) =>
        HomeAddressDialogViewModel(ref.read(homeAddressDialogUseCaseProvider)));

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

///student income page
final studentIncomePageViewModelProvider =
    ChangeNotifierProvider.autoDispose<StudentJobIncomePageViewModel>(
  (ref) => StudentJobIncomePageViewModel(
      ref.read(studentJobIncomeUseCaseProvider),
      ref.read(uploadDocumentUseCaseProvider)),
);

///state city dialog view model provider
final stateCityDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<StateCityDialogViewModel>(
        (ref) => StateCityDialogViewModel());

final registerStepFiveViewModelProvider =
    ChangeNotifierProvider.autoDispose<RegisterStepFiveViewModel>(
  (ref) => RegisterStepFiveViewModel(),
);

final calendarDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<CalendarDialogViewModel>(
  (ref) => CalendarDialogViewModel(),
);

final yearMonthDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<YearMonthDialogViewModel>(
  (ref) => YearMonthDialogViewModel(),
);
