import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UploadDocumentsUseCase
    extends BaseUseCase<LocalError, UploadDocumentsUseCaseParams, bool> {
  UploadDocumentsUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required UploadDocumentsUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class UploadDocumentsUseCaseParams extends Params {
  final String? incomeProof;
  final String? addressProof;

  UploadDocumentsUseCaseParams({
    this.incomeProof,
    this.addressProof,
  });

  @override
  Either<AppError, bool> verify() {
    //To do: change validation msg
    if (incomeProof!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_NAME,
          cause: Exception()));
    } else if (addressProof!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_NATURE,
          cause: Exception()));
    }
    return Right(true);
  }
}
