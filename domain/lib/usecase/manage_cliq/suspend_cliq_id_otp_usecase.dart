import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SuspendCliqIdOtpUseCase extends BaseUseCase<NetworkError, SuspendCliqIdOtpUseCaseParams, bool> {
  final CliqRepository _cliqRepository;

  SuspendCliqIdOtpUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required SuspendCliqIdOtpUseCaseParams params}) {
    return _cliqRepository.suspendCliqIdOtp(aliasId: params.aliasId, getToken: params.getToken);
  }
}

class SuspendCliqIdOtpUseCaseParams extends Params {
  final String aliasId;

  final bool getToken;

  SuspendCliqIdOtpUseCaseParams({
    required this.aliasId,
    required this.getToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
