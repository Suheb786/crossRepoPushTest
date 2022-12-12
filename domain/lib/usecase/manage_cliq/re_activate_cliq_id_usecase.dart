import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ReActivateCliqIdUseCase extends BaseUseCase<NetworkError, ReActivateCliqIdUseCaseParams, bool> {
  final CliqRepository _cliqRepository;

  ReActivateCliqIdUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required ReActivateCliqIdUseCaseParams params}) {
    return _cliqRepository.suspendCliqId(aliasId: params.aliasId, getToken: params.getToken);
  }
}

class ReActivateCliqIdUseCaseParams extends Params {
  final String aliasId;

  final bool getToken;

  ReActivateCliqIdUseCaseParams({
    required this.aliasId,
    required this.getToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
