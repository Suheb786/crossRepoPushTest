import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class EnterNewPasswordUseCase
    extends BaseUseCase<LocalError, EnterNewPasswordUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required EnterNewPasswordUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EnterNewPasswordUseCaseParams extends Params {
  final String currentPassword;
  final String newPassword;

  EnterNewPasswordUseCaseParams(
      {required this.currentPassword, required this.newPassword});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(currentPassword)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_PASSWORD,
          cause: Exception()));
    } else if (Validator.isEmpty(newPassword)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_NEW_PASSWORD,
          cause: Exception()));
    } else if (!Validator.isEqual(currentPassword, newPassword)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.PASSWORD_MISMATCH,
          cause: Exception()));
    }
    return Right(true);
  }
}
