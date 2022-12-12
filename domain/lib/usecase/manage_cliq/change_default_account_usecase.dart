import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ChangeDefaultAccountUseCase extends BaseUseCase<NetworkError, ChangeDefaultAccountParams, bool> {
  final CliqRepository _cliqRepository;

  ChangeDefaultAccountUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required ChangeDefaultAccountParams params}) {
    return _cliqRepository.changeDefaultAccount(
        linkType: params.linkType,
        otpCode: params.otpCode,
        identifier: params.identifier,
        aliasId: params.aliasId,
        getToken: params.getToken);
  }
}

class ChangeDefaultAccountParams extends Params {
  final String linkType;
  final String otpCode;
  final String identifier;
  final String aliasId;
  final bool getToken;

  ChangeDefaultAccountParams(
      {required this.linkType,
      required this.otpCode,
      required this.identifier,
      required this.aliasId,
      required this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
