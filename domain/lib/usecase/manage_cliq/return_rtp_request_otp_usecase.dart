import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/return_RTP_request_otp/return_RTP_request_otp.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ReturnRTPrequestOTPUsecase
    extends BaseUseCase<NetworkError, ReturnRTPrequestOTPUsecaseParams, ReturnRTPRequestOTP> {
  final CliqRepository _cliqRepository;

  ReturnRTPrequestOTPUsecase(this._cliqRepository);

  @override
  Future<Either<NetworkError, ReturnRTPRequestOTP>> execute(
      {required ReturnRTPrequestOTPUsecaseParams params}) {
    return _cliqRepository.returnRTPrequestOTP(getToken: params.getToken);
  }
}

class ReturnRTPrequestOTPUsecaseParams extends Params {
  final bool getToken;

  ReturnRTPrequestOTPUsecaseParams(this.getToken);

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
