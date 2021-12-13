import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EnterOtpUseCase
    extends BaseUseCase<NetworkError, EnterOtpUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required EnterOtpUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EnterOtpUseCaseParams extends Params {
  String? otpCode;

  EnterOtpUseCaseParams({this.otpCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
