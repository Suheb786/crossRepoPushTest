import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/approve_rtp_otp/approve_rtp_otp.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ApproveRTPOtpUseCase extends BaseUseCase<NetworkError, ApproveRTPOtpUseCaseParams, ApproveRTPOtp> {
  final CliqRepository _cliqRepository;

  ApproveRTPOtpUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, ApproveRTPOtp>> execute({required ApproveRTPOtpUseCaseParams params}) {
    return _cliqRepository.approveRTPRequestOtp();
  }
}

class ApproveRTPOtpUseCaseParams extends Params {
  ApproveRTPOtpUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
