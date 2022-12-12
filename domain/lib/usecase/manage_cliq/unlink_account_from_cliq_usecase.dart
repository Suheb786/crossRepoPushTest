import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UnlinkAccountFromCliqUseCase
    extends BaseUseCase<NetworkError, UnlinkAccountFromCliqParams, bool> {
  final CliqRepository _cliqRepository;

  UnlinkAccountFromCliqUseCase(this._cliqRepository);
  @override
  Future<Either<NetworkError, bool>> execute(
      {required UnlinkAccountFromCliqParams params}) {
    return _cliqRepository.unLinkAccountFromCliq(
        aliasId: params.aliasId,
        accountId: params.accountId,
        getToken: params.getToken);
  }
}

class UnlinkAccountFromCliqParams extends Params {
  final String aliasId;
  final String accountId;
  final bool getToken;

  UnlinkAccountFromCliqParams(
      {required this.aliasId, required this.accountId, required this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
