import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EnterCodeEVoucherPurchaseUseCase
    extends BaseUseCase<NetworkError, EnterCodeEVoucherPurchaseUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required EnterCodeEVoucherPurchaseUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EnterCodeEVoucherPurchaseUseCaseParams extends Params {
  final String otp;

  EnterCodeEVoucherPurchaseUseCaseParams({required this.otp});

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_OTP, cause: Exception()));
    }
    return Right(true);
  }
}
