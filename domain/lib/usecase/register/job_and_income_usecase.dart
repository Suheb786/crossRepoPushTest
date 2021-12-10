import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/employment_status_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/save_job_details_response.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class JobAndIncomeUseCase extends BaseUseCase<NetworkError,
    JobAndIncomeUseCaseParams, SaveJobDetailsResponse> {
  final UserRepository _repository;

  JobAndIncomeUseCase(this._repository);

  @override
  Future<Either<NetworkError, SaveJobDetailsResponse>> execute(
      {required JobAndIncomeUseCaseParams params}) {
    return _repository.saveJobInformation(
        occupation: params.occupation,
        businessType: params.businessType,
        annualIncome: params.annualIncome,
        employeeName: params.employerName,
        employerCountry: params.employerCountry,
        employerCity: params.employerCity,
        employerContact: params.employerContact,
        additionalIncome: params.isAdditionalIncome,
        additionalIncomeType: params.additionalIncomeList);
  }
}

class JobAndIncomeUseCaseParams extends Params {
  final String? occupation;
  final String? annualIncome;
  final String? employerName;
  final String? employerCountry;
  final String? employerCity;
  final String? employerContact;
  final String? businessType;
  final String? specifyBusiness;
  final EmploymentStatusEnum employmentStatusEnum;
  final bool businessTypeOther;
  final bool isAdditionalIncome;
  final List<AdditionalIncomeType> additionalIncomeList;

  JobAndIncomeUseCaseParams(
      {this.employerContact,
      this.employerCity,
      this.employerCountry,
      this.employerName,
      this.annualIncome,
      this.occupation,
      this.businessType,
      this.specifyBusiness,
      required this.employmentStatusEnum,
      required this.businessTypeOther,
      required this.isAdditionalIncome,
      required this.additionalIncomeList});

  @override
  Either<AppError, bool> verify() {
    if (employmentStatusEnum == EmploymentStatusEnum.BUSINESS_OWNER) {
      if (businessTypeOther && specifyBusiness!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.EMPTY_BUSINESS,
            cause: Exception()));
      } else if (businessType!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_BUSINESS_TYPE,
            cause: Exception()));
      }
    } else if (occupation!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_OCCUPATION,
          cause: Exception()));
    }
    if (annualIncome!.isEmpty) {
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
