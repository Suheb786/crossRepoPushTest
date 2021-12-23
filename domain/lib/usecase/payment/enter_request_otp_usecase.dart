import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EnterRequestOtpUseCase
    extends BaseUseCase<NetworkError, EnterRequestOtpUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required EnterRequestOtpUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EnterRequestOtpUseCaseParams extends Params {
  String? otpCode;

  EnterRequestOtpUseCaseParams({this.otpCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
