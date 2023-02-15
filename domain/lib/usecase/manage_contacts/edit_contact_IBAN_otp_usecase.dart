import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class EditContactOTPuseCase extends BaseUseCase<BaseError, EditContactOTPuseCaseParams, bool> {
  @override
  Future<Either<BaseError, bool>> execute({required EditContactOTPuseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EditContactOTPuseCaseParams extends Params {
  final String otp;

  EditContactOTPuseCaseParams({required this.otp});

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_OTP, cause: Exception()));
    }
    return Right(true);
  }
}
