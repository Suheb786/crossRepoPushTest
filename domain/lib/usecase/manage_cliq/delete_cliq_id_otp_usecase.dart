import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DeleteCliqIdOtpUseCase extends BaseUseCase<NetworkError, DeleteCliqIdOtpUseCaseParams, bool> {
  final CliqRepository _cliqRepository;

  DeleteCliqIdOtpUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required DeleteCliqIdOtpUseCaseParams params}) {
    return _cliqRepository.deleteCliqIdOtp(aliasId: params.aliasId, getToken: params.getToken);
  }
}

class DeleteCliqIdOtpUseCaseParams extends Params {
  final String aliasId;

  final bool getToken;

  DeleteCliqIdOtpUseCaseParams({
    required this.aliasId,
    required this.getToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
