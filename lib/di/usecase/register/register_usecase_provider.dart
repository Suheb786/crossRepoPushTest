import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/register/fatca_us_relevant_w8_address_details_usecase.dart';
import 'package:domain/usecase/register/fatca_us_relevant_w8_useCase.dart';
import 'package:domain/usecase/register/fatca_us_relevant_w9_address_details_usecase.dart';
import 'package:domain/usecase/register/fatca_us_relevant_w9_usecase.dart';
import 'package:domain/usecase/register/fatca_us_w8_tax_payer_details_usecase.dart';
import 'package:domain/usecase/register/fatca_us_w9_tax_payer_details_usecase.dart';
import 'package:domain/usecase/register/get_additional_income_source_usecase.dart';
import 'package:domain/usecase/register/get_occupation_list_usecase.dart';
import 'package:domain/usecase/register/get_purpose_of_account_opening_usecase.dart';
import 'package:domain/usecase/register/job_and_income_usecase.dart';
import 'package:domain/usecase/register/nature_of_special_needs_usecase.dart';
import 'package:domain/usecase/register/purpose_of_account_opening_usecase.dart';
import 'package:domain/usecase/register/relationship_with_pep_usecase.dart';
import 'package:domain/usecase/register/schedule_video_call_usecase.dart';
import 'package:domain/usecase/register/tax_report_information_usecase.dart';
import 'package:domain/usecase/register/taxation_details_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[GetOccupationUseCase] provider
final getOccupationUseCaseProvider = Provider.autoDispose<GetOccupationUseCase>(
  (ref) => GetOccupationUseCase(ref.read(registerRepoProvider)),
);

///[GetPurposeOfAccountOpeningUseCase] provider
final purposeOfAccountOpeningUseCaseProvider =
    Provider.autoDispose<GetPurposeOfAccountOpeningUseCase>(
  (ref) => GetPurposeOfAccountOpeningUseCase(ref.read(registerRepoProvider)),
);

///[GetAdditionalIncomeSourceUseCase] provider
final additionalIncomeSourceUseCaseProvider =
    Provider.autoDispose<GetAdditionalIncomeSourceUseCase>(
  (ref) => GetAdditionalIncomeSourceUseCase(ref.read(registerRepoProvider)),
);

///[JobAndIncomeUseCase] provider
final jobAndIncomeUseCaseProvider = Provider.autoDispose<JobAndIncomeUseCase>(
  (ref) => JobAndIncomeUseCase(),
);

///[TaxationDetailsUseCase] provider
final taxationDetailsUseCaseProvider =
    Provider.autoDispose<TaxationDetailsUseCase>(
  (ref) => TaxationDetailsUseCase(),
);

///[TaxReportInformationUseCase] provider
final taxReportInformationUseCaseProvider =
    Provider.autoDispose<TaxReportInformationUseCase>(
  (ref) => TaxReportInformationUseCase(),
);

///[NatureOfSpecialNeedsUseCase] provider
final natureOfSpecialNeedsUseCaseProvider =
    Provider.autoDispose<NatureOfSpecialNeedsUseCase>(
  (ref) => NatureOfSpecialNeedsUseCase(ref.read(registerRepoProvider)),
);

///[RelationshipWithPEPUseCase] provider
final relationshipWithPEPUseCaseProvider =
    Provider.autoDispose<RelationshipWithPEPUseCase>(
  (ref) => RelationshipWithPEPUseCase(ref.read(registerRepoProvider)),
);

///[PurposeOfAccountOpeningUseCase] provider
final purposeOfAccountsOpeningUseCaseProvider =
    Provider.autoDispose<PurposeOfAccountOpeningUseCase>(
        (ref) => PurposeOfAccountOpeningUseCase());

///[FatcaUSRelevantW8UseCase] provider
final fatcaUSRelevantW8UseCaseProvider =
    Provider.autoDispose<FatcaUSRelevantW8UseCase>(
        (ref) => FatcaUSRelevantW8UseCase());

///[FatcaUSRelevantW8AddressDetailsUseCase] provider
final fatcaUSRelevantW8AddressDetailsUseCaseProvider =
    Provider.autoDispose<FatcaUSRelevantW8AddressDetailsUseCase>(
        (ref) => FatcaUSRelevantW8AddressDetailsUseCase());

///[FatcaUSRelevantW9UseCase] provider
final fatcaUSRelevantW9UseCaseProvider =
    Provider.autoDispose<FatcaUSRelevantW9UseCase>(
        (ref) => FatcaUSRelevantW9UseCase());

///[FatcaUSRelevantW9AddressDetailsUseCase] provider
final fatcaUSRelevantW9AddressDetailsUseCaseProvider =
    Provider.autoDispose<FatcaUSRelevantW9AddressDetailsUseCase>(
        (ref) => FatcaUSRelevantW9AddressDetailsUseCase());

///[FatcaUSW9TaxPayerDetailsUseCase] provider
final fatcaUSW9TaxPayerDetailsUseCaseProvider =
    Provider.autoDispose<FatcaUSW9TaxPayerDetailsUseCase>(
        (ref) => FatcaUSW9TaxPayerDetailsUseCase());

///[FatcaUSW9TaxPayerDetailsUseCase] provider
final fatcaUSW8TaxPayerDetailsUseCaseProvider =
    Provider.autoDispose<FatcaUSW8TaxPayerDetailsUseCase>(
        (ref) => FatcaUSW8TaxPayerDetailsUseCase());

///[ScheduleVideoCallUseCase] provider
final scheduleVideoCallUseCaseProvider =
    Provider.autoDispose<ScheduleVideoCallUseCase>(
  (ref) => ScheduleVideoCallUseCase(),
);
