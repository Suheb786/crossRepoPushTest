import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ReasonToRejectValidationUseCase
    extends BaseUseCase<BaseError, ReasonToRejectValidationUseCaseParams, bool> {
  @override
  Future<Either<BaseError, bool>> execute({required ReasonToRejectValidationUseCaseParams params}) async {
    return Future.value(Right(true));
  }
}

class ReasonToRejectValidationUseCaseParams extends Params {
  final String reason;

  ReasonToRejectValidationUseCaseParams({required this.reason});

  @override
  Either<AppError, bool> verify() {
    if (reason.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.REJECT_REASON_TYPE, cause: Exception()));
    }
    return Right(true);
  }
}
