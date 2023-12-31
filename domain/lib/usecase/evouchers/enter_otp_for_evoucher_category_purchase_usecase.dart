import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EnterOtpForEVoucherCategoryPurchaseUseCase
    extends BaseUseCase<NetworkError, EnterOtpForEVoucherCategoryPurchaseUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required EnterOtpForEVoucherCategoryPurchaseUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EnterOtpForEVoucherCategoryPurchaseUseCaseParams extends Params {
  final String otp;

  EnterOtpForEVoucherCategoryPurchaseUseCaseParams({required this.otp});

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_OTP, cause: Exception()));
    }
    return Right(true);
  }
}
