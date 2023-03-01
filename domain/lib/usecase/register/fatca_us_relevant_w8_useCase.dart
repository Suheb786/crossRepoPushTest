import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FatcaUSRelevantW8UseCase extends BaseUseCase<LocalError, FatcaUSRelevantW8UseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute({required FatcaUSRelevantW8UseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class FatcaUSRelevantW8UseCaseParams extends Params {
  final String? name;
  final String? dob;
  final String? country;

  FatcaUSRelevantW8UseCaseParams({this.name, this.dob, this.country});

  @override
  Either<AppError, bool> verify() {
    if (name!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.INVALID_NAME_AS_PER_TAX_RETURN, cause: Exception()));
    } else if (dob!.isEmpty) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_DOB, cause: Exception()));
    } else if (country!.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_CITIZENSHIP, cause: Exception()));
    }
    return Right(true);
  }
}
