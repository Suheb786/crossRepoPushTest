import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class NotifyUseCase extends BaseUseCase<LocalError, NotifyUseCaseParams, bool> {
  NotifyUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required NotifyUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class NotifyUseCaseParams extends Params {
  final String? emailAddress;

  NotifyUseCaseParams({this.emailAddress});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(emailAddress!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_EMAIL,
          cause: Exception()));
    } else if (!Validator.validateEmail(emailAddress!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EMAIL,
          cause: Exception()));
    }
    return Right(true);
  }
}
