import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DeleteCliqIdUseCase extends BaseUseCase<NetworkError, DeleteCliqIdUseCaseParams, bool> {
  final CliqRepository _cliqRepository;

  DeleteCliqIdUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required DeleteCliqIdUseCaseParams params}) {
    return _cliqRepository.deleteCliqId(
        aliasId: params.aliasId, otpCode: params.otpCode, getToken: params.getToken);
  }
}

class DeleteCliqIdUseCaseParams extends Params {
  final String aliasId;
  final String otpCode;

  final bool getToken;

  DeleteCliqIdUseCaseParams({
    required this.aliasId,
    required this.otpCode,
    required this.getToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
