import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FatcaUSW9TaxPayerDetailsUseCase extends BaseUseCase<LocalError,
    FatcaUSW9TaxPayerDetailsUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required FatcaUSW9TaxPayerDetailsUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class FatcaUSW9TaxPayerDetailsUseCaseParams extends Params {
  final String? taxPayerType;
  bool isSocialSecurityTaxPayer;
  final String? socialSecurityNumber;
  final bool declarationSelected;

  FatcaUSW9TaxPayerDetailsUseCaseParams(
      {this.taxPayerType,
      this.socialSecurityNumber,
      required this.isSocialSecurityTaxPayer,
      required this.declarationSelected});

  @override
  Either<AppError, bool> verify() {
    if (taxPayerType!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_TAX_PAYER,
          cause: Exception()));
    } else if (isSocialSecurityTaxPayer && socialSecurityNumber!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_SECURITY_NUMBER,
          cause: Exception()));
    } else if (!declarationSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_DECLARATION_SELECTION,
          cause: Exception()));
    }
    return Right(true);
  }
}
