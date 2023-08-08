import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EVoucherFilterValidationUseCase
    extends BaseUseCase<NetworkError, EVoucherFilterValidationUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required EVoucherFilterValidationUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EVoucherFilterValidationUseCaseParams extends Params {
  String category;
  String region;
  String minValue;
  String maxValue;

  EVoucherFilterValidationUseCaseParams({
    required this.category,
    required this.region,
    required this.minValue,
    required this.maxValue,
  });

  @override
  Either<AppError, bool> verify() {
    if (category.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.SELECT_CATEGORY, cause: Exception()));
    } else if (region.isEmpty) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.SELECT_REGION, cause: Exception()));
    } else if (minValue.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.SELECT_MIN_VALUE, cause: Exception()));
    } else if (maxValue.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.SELECT_MAX_VALUE, cause: Exception()));
    } else if (double.parse(minValue) > double.parse(maxValue)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.MAX_VALUE_SHOULD_BE_GREATER_THAN_MIN,
          cause: Exception()));
    }
    return Right(true);
  }
}
