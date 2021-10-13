import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EmploymentStatusUseCase
    extends BaseUseCase<LocalError, EmploymentStatusUseCaseParams, bool> {
  EmploymentStatusUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required EmploymentStatusUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EmploymentStatusUseCaseParams extends Params {
  final String? employmentStatus;
  final String? occupation;
  final String? mainSourceIncome;
  final String? monthlyIncome;
  final String? annualIncome;
  final String? purposeOfAccountOpening;
  final String? employerName;
  final String? employerCountry;
  final String? employerCity;
  final String? employerContact;
  final String? additionalSourceIncome;
  final String? totalAdditionalIncome;

  EmploymentStatusUseCaseParams(
      {this.employerContact,
      this.totalAdditionalIncome,
      this.employerCity,
      this.employerCountry,
      this.employerName,
      this.purposeOfAccountOpening,
      this.annualIncome,
      this.monthlyIncome,
      this.occupation,
      this.employmentStatus,
      this.additionalSourceIncome,
      this.mainSourceIncome});

  @override
  Either<AppError, bool> verify() {
    if (employmentStatus!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EMPLOYMENT_STATUS,
          cause: Exception()));
    } else if (occupation!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_OCCUPATION,
          cause: Exception()));
    } else if (mainSourceIncome!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_SOURCE_INCOME,
          cause: Exception()));
    } else if (monthlyIncome!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_MONTHLY_INCOME,
          cause: Exception()));
    } else if (annualIncome!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_ANNUAL_INCOME,
          cause: Exception()));
    } else if (purposeOfAccountOpening!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_PURPOSE_OF_ACCOUNT_OPENING,
          cause: Exception()));
    } else if (employerName!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EMPLOYER_NAME,
          cause: Exception()));
    } else if (employerCountry!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EMPLOYER_COUNTRY,
          cause: Exception()));
    } else if (employerCity!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EMPLOYER_CITY,
          cause: Exception()));
    } else if (employerContact!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EMPLOYER_CONTACT,
          cause: Exception()));
    } else if (additionalSourceIncome!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_ADDITIONAL_SOURCE_INCOME,
          cause: Exception()));
    } else if (totalAdditionalIncome!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_TOTAL_ADDITIONAL_INCOME,
          cause: Exception()));
    }
    return Right(true);
  }
}
