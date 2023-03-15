import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class ReturnPaymentTransactionUsecase
    extends BaseUseCase<NetworkError, ReturnPaymentTransactionUsecaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required ReturnPaymentTransactionUsecaseParams params}) {
    return Future.value(Right(true));
  }
}

class ReturnPaymentTransactionUsecaseParams extends Params {
  final String returnReason;

  ReturnPaymentTransactionUsecaseParams({
    required this.returnReason,
  });

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(returnReason)) {
      return Left(AppError(
          cause: Exception(),
          error: ErrorInfo(message: ""),
          type: ErrorType.INVALID_VERIFY_INFO_DECLARATION_SELECTION));
    }
    return Right(true);
  }
}
