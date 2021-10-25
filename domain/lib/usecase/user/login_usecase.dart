import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class LoginUseCase extends BaseUseCase<LocalError, LoginUseCaseParams, bool> {
  LoginUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required LoginUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class LoginUseCaseParams extends Params {
  final String email;
  final String password;

  LoginUseCaseParams({required this.email, required this.password});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(email)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_EMAIL,
          cause: Exception()));
    } else if (!Validator.validateEmail(email)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EMAIL,
          cause: Exception()));
    }
    if (Validator.isEmpty(password)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_PASSWORD,
          cause: Exception()));
    }
    return Right(true);
  }
}
