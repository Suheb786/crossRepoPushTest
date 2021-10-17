import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/register/get_occupation_list_usecase.dart';
import 'package:domain/usecase/register/get_purpose_of_account_opening_usecase.dart';
import 'package:domain/usecase/register/get_additional_income_source_usecase.dart';
import 'package:domain/usecase/register/employment_status_usecase.dart';
import 'package:domain/usecase/register/taxation_details_usecase.dart';
import 'package:domain/usecase/register/tax_report_information_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domain/usecase/register/nature_of_special_needs_usecase.dart';
import 'package:domain/usecase/register/relationship_with_pep_usecase.dart';

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

///[EmploymentDetailsUseCase] provider
final employmentDetailsUseCaseProvider =
    Provider.autoDispose<EmploymentStatusUseCase>(
  (ref) => EmploymentStatusUseCase(),
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
