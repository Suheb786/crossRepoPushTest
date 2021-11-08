import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ProfileDetailsUseCase
    extends BaseUseCase<LocalError, ProfileDetailsUseCaseParams, bool> {
  ProfileDetailsUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required ProfileDetailsUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class ProfileDetailsUseCaseParams extends Params {
  final String? spouseName;
  final String? natureOfNeeds;
  final String? employeeStatus;
  final bool isMarried;
  final bool isPerson;
  final bool isRelative;
  bool isEmploymentStatusOthers;
  final String? jobName;
  bool isBeneficialOwnerACcount;

  ProfileDetailsUseCaseParams(
      {this.spouseName,
      this.natureOfNeeds,
      this.employeeStatus,
      required this.isMarried,
      required this.isPerson,
      required this.isRelative,
      required this.isEmploymentStatusOthers,
      this.jobName,
      required this.isBeneficialOwnerACcount});

  @override
  Either<AppError, bool> verify() {
    if (isMarried && spouseName!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_NAME,
          cause: Exception()));
    } else if (isPerson && natureOfNeeds!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_NATURE,
          cause: Exception()));
    } else if (employeeStatus!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EMPLOYEE_STATUS,
          cause: Exception()));
    } else if (isEmploymentStatusOthers && jobName!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_JOB_NAME,
          cause: Exception()));
    } else if (!isBeneficialOwnerACcount) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_BENEFICIAL_OWNER_ACCOUNT,
          cause: Exception()));
    }
    return Right(true);
  }
}
