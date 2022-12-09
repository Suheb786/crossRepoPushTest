import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EditCliqIdUseCase extends BaseUseCase<NetworkError, EditCliqIdUseCaseParams, bool> {
  final CliqRepository _cliqRepository;

  EditCliqIdUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required EditCliqIdUseCaseParams params}) {
    return _cliqRepository.editCliqID(
        isAlias: params.isAlias,
        aliasId: params.aliasId,
        aliasValue: params.aliasValue,
        OtpCode: params.OtpCode,
        getToken: params.getToken);
  }
}

class EditCliqIdUseCaseParams extends Params {
  final bool isAlias;

  final String aliasId;

  final String aliasValue;

  final String OtpCode;

  final bool getToken;

  EditCliqIdUseCaseParams(
      {required this.isAlias,
      required this.aliasValue,
      required this.aliasId,
      required this.getToken,
      required this.OtpCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
