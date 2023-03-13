import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SuspendCliqIdUseCase extends BaseUseCase<NetworkError, SuspendCliqIdUseCaseParams, bool> {
  final CliqRepository _cliqRepository;

  SuspendCliqIdUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required SuspendCliqIdUseCaseParams params}) {
    return _cliqRepository.suspendCliqId(
        aliasId: params.aliasId, otpCode: params.otpCode, getToken: params.getToken);
  }
}

class SuspendCliqIdUseCaseParams extends Params {
  final String aliasId;
  final String otpCode;

  final bool getToken;

  SuspendCliqIdUseCaseParams({
    required this.aliasId,
    required this.otpCode,
    required this.getToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
