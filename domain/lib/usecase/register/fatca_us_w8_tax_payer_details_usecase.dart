import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FatcaUSW8TaxPayerDetailsUseCase extends BaseUseCase<LocalError,
    FatcaUSW8TaxPayerDetailsUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required FatcaUSW8TaxPayerDetailsUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class FatcaUSW8TaxPayerDetailsUseCaseParams extends Params {
  final String? taxPayerType;
  bool isUSTaxPayer;
  bool wantToClaimTaxTreatyBenefits;
  final String? beneficialAddress;
  final String? identificationNumber;
  final String? referenceNumber;
  final String? typeOfIncome;
  final String? explanation;
  final String? provisionClaimArticle;
  final String? treatyClaimRate;

  FatcaUSW8TaxPayerDetailsUseCaseParams(
      {this.taxPayerType,
      this.beneficialAddress,
      required this.isUSTaxPayer,
      this.identificationNumber,
      this.referenceNumber,
      this.explanation,
      this.typeOfIncome,
      required this.wantToClaimTaxTreatyBenefits,
      this.treatyClaimRate,
      this.provisionClaimArticle});

  @override
  Either<AppError, bool> verify() {
    if (taxPayerType!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_TAX_PAYER,
          cause: Exception()));
    } else if (isUSTaxPayer) {
      if (identificationNumber!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_IDENTIFICATION_NUMBER,
            cause: Exception()));
      } else if (referenceNumber!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_REFERENCE_NO,
            cause: Exception()));
      }
    } else if (wantToClaimTaxTreatyBenefits) {
      if (beneficialAddress!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_BENEFICIAL_ADDRESS,
            cause: Exception()));
      } else if (provisionClaimArticle!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_PROVISION_CLAIM,
            cause: Exception()));
      } else if (treatyClaimRate!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_TREATY_CLAIM_RATE,
            cause: Exception()));
      } else if (typeOfIncome!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_INCOME_TYPE,
            cause: Exception()));
      } else if (explanation!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_EXPLANATION,
            cause: Exception()));
      }
    }
    return Right(true);
  }
}
