import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PurposeOfAccountOpeningUseCase extends BaseUseCase<LocalError,
    PurposeOfAccountOpeningUseCaseParams, bool> {
  PurposeOfAccountOpeningUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required PurposeOfAccountOpeningUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class PurposeOfAccountOpeningUseCaseParams extends Params {
  final String? purposeOfAccountOpening;
  final String? typesOfTransaction;
  final String? expectedMonthlyTransaction;
  final String? expectedAnnualTransaction;

  PurposeOfAccountOpeningUseCaseParams(
      {this.purposeOfAccountOpening,
      this.expectedAnnualTransaction,
      this.expectedMonthlyTransaction,
      this.typesOfTransaction});

  @override
  Either<AppError, bool> verify() {
    if (purposeOfAccountOpening!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_PURPOSE_OF_ACCOUNT_OPENING,
          cause: Exception()));
    } else if (typesOfTransaction!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_TYPES_OF_TRANSACTION,
          cause: Exception()));
    } else if (expectedMonthlyTransaction!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EXPECTED_MONTHLY_TRANSACTION,
          cause: Exception()));
    } else if (expectedAnnualTransaction!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EXPECTED_ANNUAL_TRANSACTION,
          cause: Exception()));
    }
    return Right(true);
  }
}
