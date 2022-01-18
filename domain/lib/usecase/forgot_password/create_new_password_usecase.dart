import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/forget_password/forget_password_response.dart';
import 'package:domain/repository/forget_password/forget_password_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class CreateNewPasswordUseCase extends BaseUseCase<NetworkError,
    CreateNewPasswordUseCaseParams, ForgetPasswordResponse> {
  final ForgetPasswordRepository _repository;

  CreateNewPasswordUseCase(this._repository);

  @override
  Future<Either<NetworkError, ForgetPasswordResponse>> execute(
      {required CreateNewPasswordUseCaseParams params}) {
    return _repository.resetPassword(
        email: params.email,
        expiryDate: params.idExpiry,
        nationalId: params.idNo,
        createPassword: params.createPassword,
        confirmPassword: params.confirmPassword);
  }
}

class CreateNewPasswordUseCaseParams extends Params {
  final String createPassword;
  final String confirmPassword;
  final String email;
  final String idNo;
  final String idExpiry;
  final bool minimumEightCharacters;
  final bool hasUpperCase;
  final bool hasSymbol;
  final bool containsDigit;

  CreateNewPasswordUseCaseParams(
      {required this.createPassword,
      required this.confirmPassword,
      required this.containsDigit,
      required this.hasSymbol,
      required this.hasUpperCase,
      required this.minimumEightCharacters,
      required this.email,
      required this.idExpiry,
      required this.idNo});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(createPassword)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_PASSWORD,
          cause: Exception()));
    } else if (!minimumEightCharacters ||
        !hasUpperCase ||
        !hasSymbol ||
        !containsDigit) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.PASSWORD_NOT_MEET_CRITERIA,
          cause: Exception()));
    } else if (Validator.isEmpty(confirmPassword)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_CONFIRM_PASSWORD,
          cause: Exception()));
    } else if (!Validator.isEqual(confirmPassword, createPassword)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.PASSWORD_MISMATCH,
          cause: Exception()));
    }
    return Right(true);
  }
}
