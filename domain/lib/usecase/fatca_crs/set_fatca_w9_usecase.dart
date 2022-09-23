import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/fatca_crs/fatca_w9_data.dart';
import 'package:domain/repository/fatca_crs/fatca_crs_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SetFatcaW9UseCase extends BaseUseCase<NetworkError, SetFatcaW9UseCaseParams, bool> {
  final FatcaCrsRepository _repository;

  SetFatcaW9UseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required SetFatcaW9UseCaseParams params}) {
    return _repository.saveFatcaW9(
        signatureId: params.fatcaW9Data.signatureId!,
        postCode: params.fatcaW9Data.postCode!,
        taxPayer: params.fatcaW9Data.taxPayer!,
        city: params.fatcaW9Data.city!,
        usAddress: params.fatcaW9Data.usAddress!,
        countryCode: params.fatcaW9Data.country!,
        state: params.fatcaW9Data.state!,
        namePerIncomeTaxReturn: params.fatcaW9Data.namePerIncomeTaxReturn!,
        exemptPayeeCode: params.fatcaW9Data.exemptPayeeCode!,
        accountNumberList: params.fatcaW9Data.accountNumberList!,
        additionalRequester: params.fatcaW9Data.additionalRequester!,
        businessName: params.fatcaW9Data.businessName!,
        employerTin: params.fatcaW9Data.employerTin!,
        exemptFromFatcaReportingCode: params.fatcaW9Data.exemptFromFatcaReportingCode!,
        requesterCity: params.fatcaW9Data.requesterCity!,
        requesterName: params.fatcaW9Data.requesterName!,
        requesterPostCode: params.fatcaW9Data.requesterPostCode!,
        requesterCountryCode: params.fatcaW9Data.requesterCountry!,
        requesterState: params.fatcaW9Data.requesterState!,
        requesterUsAddress: params.fatcaW9Data.requesterUsAddress!,
        socialSecurityNumber: params.fatcaW9Data.socialSecurityNumber!);
  }
}

class SetFatcaW9UseCaseParams extends Params {
  final FatcaW9Data fatcaW9Data;
  final bool declarationSelected;
  final bool verifyInfoDeclarationSelected;

  SetFatcaW9UseCaseParams(
      {required this.fatcaW9Data,
      required this.declarationSelected,
      required this.verifyInfoDeclarationSelected});

  @override
  Either<AppError, bool> verify() {
    if (!declarationSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.INVALID_DECLARATION_SELECTION, cause: Exception()));
    } else if (!verifyInfoDeclarationSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_VERIFY_INFO_DECLARATION_SELECTION,
          cause: Exception()));
    }
    return Right(true);
  }
}
