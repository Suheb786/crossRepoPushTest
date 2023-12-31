import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/re_activate_cliq_id/re_activate_cliq_id_otp.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ReActivateCliqIdOtpUseCase
    extends BaseUseCase<NetworkError, ReActivateCliqIdOtpUseCaseParams, ReActivateCliqIdOtp> {
  final CliqRepository _cliqRepository;

  ReActivateCliqIdOtpUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, ReActivateCliqIdOtp>> execute(
      {required ReActivateCliqIdOtpUseCaseParams params}) {
    return _cliqRepository.reActivateCliqIdOtp(aliasId: params.aliasId, getToken: params.getToken);
  }
}

class ReActivateCliqIdOtpUseCaseParams extends Params {
  final String aliasId;

  final bool getToken;

  ReActivateCliqIdOtpUseCaseParams({
    required this.aliasId,
    required this.getToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
