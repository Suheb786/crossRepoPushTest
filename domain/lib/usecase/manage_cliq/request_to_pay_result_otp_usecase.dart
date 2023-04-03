import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/reuest_to_pay_result_otp/request_to_pay_result_otp.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestToPayResultOtpUseCase
    extends BaseUseCase<NetworkError, RequestToPayResultOtpUseCaseParams, RequestToPayResultOtp> {
  final CliqRepository _cliqRepository;

  RequestToPayResultOtpUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, RequestToPayResultOtp>> execute(
      {required RequestToPayResultOtpUseCaseParams params}) {
    return _cliqRepository.requestToPayResultOtp();
  }
}

class RequestToPayResultOtpUseCaseParams extends Params {
  RequestToPayResultOtpUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
