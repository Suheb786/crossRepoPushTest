import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class CreatePasswordUseCase
    extends BaseUseCase<LocalError, CreatePasswordUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required CreatePasswordUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class CreatePasswordUseCaseParams extends Params {
  final String createPassword;
  final String confirmPassword;

  CreatePasswordUseCaseParams(
      {required this.createPassword, required this.confirmPassword});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(createPassword)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_PASSWORD,
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
