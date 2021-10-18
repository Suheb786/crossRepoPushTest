import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class JobAndIncomeUseCase
    extends BaseUseCase<LocalError, JobAndIncomeUseCaseParams, bool> {
  JobAndIncomeUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required JobAndIncomeUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class JobAndIncomeUseCaseParams extends Params {
  final String? occupation;
  final String? mainSourceIncome;
  final String? annualIncome;
  final String? employerName;
  final String? employerCountry;
  final String? employerCity;
  final String? employerContact;

  JobAndIncomeUseCaseParams(
      {this.employerContact,
      this.employerCity,
      this.employerCountry,
      this.employerName,
      this.annualIncome,
      this.occupation,
      this.mainSourceIncome});

  @override
  Either<AppError, bool> verify() {
    if (occupation!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_OCCUPATION,
          cause: Exception()));
    } else if (mainSourceIncome!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_SOURCE_INCOME,
          cause: Exception()));
    } else if (annualIncome!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_ANNUAL_INCOME,
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
    }
    return Right(true);
  }
}
