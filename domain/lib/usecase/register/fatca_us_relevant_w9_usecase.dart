import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FatcaUSRelevantW9UseCase extends BaseUseCase<LocalError, FatcaUSRelevantW9UseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute({required FatcaUSRelevantW9UseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class FatcaUSRelevantW9UseCaseParams extends Params {
  final String? nameAsPerTax;
  final String? businessName;

  FatcaUSRelevantW9UseCaseParams({this.nameAsPerTax, this.businessName});

  @override
  Either<AppError, bool> verify() {
    if (nameAsPerTax!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.INVALID_NAME_AS_PER_TAX_RETURN, cause: Exception()));
    }
    return Right(true);
  }
}
