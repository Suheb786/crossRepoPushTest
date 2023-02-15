import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AddLInkAccountUseCase extends BaseUseCase<NetworkError, AddLinkAccountUseCaseParams, bool> {
  final CliqRepository _cliqRepository;

  AddLInkAccountUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required AddLinkAccountUseCaseParams params}) {
    return _cliqRepository.addLinkAccount(
        aliasId: params.aliasId,
        linkType: params.linkType,
        accountNumber: params.accountNumber,
        isAlias: params.isAlias,
        aliasValue: params.aliasValue,
        getToken: params.getToken);
  }
}

class AddLinkAccountUseCaseParams extends Params {
  final String aliasId;
  final String linkType;
  final String accountNumber;
  final bool isAlias;
  final String aliasValue;
  final bool getToken;

  AddLinkAccountUseCaseParams(
      {required this.aliasId,
      required this.linkType,
      required this.accountNumber,
      required this.isAlias,
      required this.aliasValue,
      required this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
