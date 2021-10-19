import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/register/get_occupation_list_usecase.dart';
import 'package:domain/usecase/register/get_purpose_of_account_opening_usecase.dart';
import 'package:domain/usecase/register/get_additional_income_source_usecase.dart';
import 'package:domain/usecase/register/job_and_income_usecase.dart';
import 'package:domain/usecase/register/taxation_details_usecase.dart';
import 'package:domain/usecase/register/tax_report_information_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domain/usecase/register/nature_of_special_needs_usecase.dart';
import 'package:domain/usecase/register/relationship_with_pep_usecase.dart';
import 'package:domain/usecase/register/purpose_of_account_opening_usecase.dart';
import 'package:domain/usecase/register/fatca_and_pep_details_usecase.dart';
import 'package:domain/usecase/register/fatca_us_relevant_w8_useCase.dart';

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

///[FatcaAndPEPDetailsUseCase] provider
final fatcaAndPEPDetailsUseCaseProvider =
    Provider.autoDispose<FatcaAndPEPDetailsUseCase>(
        (ref) => FatcaAndPEPDetailsUseCase());

///[FatcaAndPEPDetailsUseCase] provider
final fatcaUSRelevantW8UseCaseProvider =
    Provider.autoDispose<FatcaUSRelevantW8UseCase>(
        (ref) => FatcaUSRelevantW8UseCase());
