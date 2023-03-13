import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ReActivateCliqIdUseCase extends BaseUseCase<NetworkError, ReActivateCliqIdUseCaseParams, bool> {
  ReActivateCliqIdUseCase(this._cliqRepository);

  final CliqRepository _cliqRepository;

  @override
  Future<Either<NetworkError, bool>> execute({required ReActivateCliqIdUseCaseParams params}) {
    return _cliqRepository.reActivateCliqId(
        aliasId: params.aliasId, otpCode: params.otpCode, getToken: params.getToken);
  }
}

class ReActivateCliqIdUseCaseParams extends Params {
  ReActivateCliqIdUseCaseParams({
    required this.aliasId,
    required this.otpCode,
    required this.getToken,
  });

  final String aliasId;
  final String otpCode;
  final bool getToken;

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
