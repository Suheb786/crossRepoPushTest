import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RegisterNumberUseCase extends BaseUseCase<LocalError, RegisterNumberUseCaseParams, bool> {
  RegisterNumberUseCase();

  @override
  Future<Either<LocalError, bool>> execute({required RegisterNumberUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class RegisterNumberUseCaseParams extends Params {
  final String mobileNumber;
  final String? countryCode;
  final int isMobileNoExist;

  RegisterNumberUseCaseParams(
      {required this.mobileNumber,
      this.countryCode,
      required this.isMobileNoExist});

  @override
  Either<AppError, bool> verify() {
    if (mobileNumber.isEmpty || mobileNumber.length < 8) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_MOBILE, cause: Exception()));
    } else if (isMobileNoExist == 1) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.MOBILE_ALREADY_EXIST, cause: Exception()));
    }
    return Right(true);
  }
}
