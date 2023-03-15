import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class ReturnPaymentOTPUseCase extends BaseUseCase<NetworkError, ReturnPaymentOTPUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required ReturnPaymentOTPUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class ReturnPaymentOTPUseCaseParams extends Params {
  final String otp;

  ReturnPaymentOTPUseCaseParams({required this.otp});

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(
        AppError(
          cause: Exception(),
          error: ErrorInfo(message: ""),
          type: ErrorType.INVALID_OTP,
        ),
      );
    }
    return Right(true);
  }
}
