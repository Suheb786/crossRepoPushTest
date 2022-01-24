import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/fatca_crs/fatca_w8_data.dart';
import 'package:domain/repository/fatca_crs/fatca_crs_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SetFatcaW8UseCase
    extends BaseUseCase<NetworkError, SetFatcaW8UseCaseParams, bool> {
  final FatcaCrsRepository _repository;

  SetFatcaW8UseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required SetFatcaW8UseCaseParams params}) {
    return _repository.saveFatcaW8(
        stateId: params.fatcaW8Data.state!,
        cityId: params.fatcaW8Data.city!,
        taxPayer: params.fatcaW8Data.taxPayer!,
        permanentResidenceAddress:
            params.fatcaW8Data.permenantResidenceAddress!,
        citizenShipCountry: params.fatcaW8Data.citizenShipCountry!,
        postCode: params.fatcaW8Data.postCode!,
        beneficialOwnerResident: params.fatcaW8Data.beneficialOwnerResident!,
        countryIsoCode: params.fatcaW8Data.country!,
        dateOfBirth: params.fatcaW8Data.dateOfBirth!,
        differentMailingCity: params.fatcaW8Data.differentMailingCity!,
        differentMailingCountry: params.fatcaW8Data.differentMailingCountry!,
        differentMailingPostCode: params.fatcaW8Data.differentMailingPostCode!,
        differentMailingState: params.fatcaW8Data.differentMailingState!,
        explanation: params.fatcaW8Data.explanation!,
        foreignTaxPayerTin: params.fatcaW8Data.foreignTaxPayerTin!,
        isClaimedTaxTreatBenefits: params.fatcaW8Data.claimTaxTreatBenefits!,
        isDifferentMailingAddress: params.fatcaW8Data.differentMailingAddress!,
        mailingAddressLine: params.fatcaW8Data.mailingAddressLine!,
        nameIncomeTaxReturn: params.fatcaW8Data.nameIncomeTaxReturn!,
        provisionOrClaim: params.fatcaW8Data.provisionOrClaim!,
        referenceNumber: params.fatcaW8Data.referenceNumber!,
        signatureId: params.fatcaW8Data.signatureId!,
        treatyClaimRate: params.fatcaW8Data.treatyClaimRate!,
        typeOfIncome: params.fatcaW8Data.typeOfIncome!,
        usTaxPayerTin: params.fatcaW8Data.usTaxPayerTin!);
  }
}

class SetFatcaW8UseCaseParams extends Params {
  final FatcaW8Data fatcaW8Data;
  final bool declarationSelected;
  final bool verifyInfoDeclarationSelected;

  SetFatcaW8UseCaseParams(
      {required this.fatcaW8Data,
      required this.declarationSelected,
      required this.verifyInfoDeclarationSelected});

  @override
  Either<AppError, bool> verify() {
    if (!declarationSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_DECLARATION_SELECTION,
          cause: Exception()));
    } else if (!verifyInfoDeclarationSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_VERIFY_INFO_DECLARATION_SELECTION,
          cause: Exception()));
    }
    return Right(true);
  }
}
