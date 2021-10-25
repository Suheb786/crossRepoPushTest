import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class SendDocumentsUseCase
    extends BaseUseCase<LocalError, SendDocumentsUseCaseParams, bool> {
  SendDocumentsUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required SendDocumentsUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class SendDocumentsUseCaseParams extends Params {
  final String? incomeProof;
  final String? addressProof;

  SendDocumentsUseCaseParams({
    this.incomeProof,
    this.addressProof,
  });

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(incomeProof!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_INCOME_DOCUMENT,
          cause: Exception()));
    } else if (Validator.isEmpty(addressProof!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_ADDRESS_DOCUMENT,
          cause: Exception()));
    } else {
      return Right(true);
    }
  }
}
