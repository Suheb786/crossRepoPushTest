import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class BlinkCreditCardUseCase
    extends BaseUseCase<NetworkError, BlinkCreditCardUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required BlinkCreditCardUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class BlinkCreditCardUseCaseParams extends Params {
  bool? isChecked;

  BlinkCreditCardUseCaseParams({this.isChecked});

  @override
  Either<AppError, bool> verify() {
    if (isChecked == null || !isChecked!) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_CHECKED_VALUE,
          cause: Exception()));
    }
    return Right(true);
  }
}
