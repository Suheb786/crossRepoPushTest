import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class TaxReportInformationUseCase extends BaseUseCase<LocalError, TaxReportInformationUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute({required TaxReportInformationUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class TaxReportInformationUseCaseParams extends Params {
  final String? taxCountry;
  final String? tinNumber;
  final String? reasonOfUnavailability;
  final String? explainReason;

  TaxReportInformationUseCaseParams(
      {this.taxCountry, this.tinNumber, this.reasonOfUnavailability, this.explainReason});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(taxCountry!)) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_TAX_COUNTRY, cause: Exception()));
    } else if (Validator.isEmpty(tinNumber!)) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_TIN_NUMBER, cause: Exception()));
    } else if (Validator.isEmpty(reasonOfUnavailability!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_REASON_OF_UNAVAILABILITY,
          cause: Exception()));
    } else if (Validator.isEmpty(explainReason!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EXPLANATION_FOR_UNAVAILABILITY,
          cause: Exception()));
    }
    return Right(true);
  }
}
