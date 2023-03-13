import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AddLInkAccountOtpUseCase extends BaseUseCase<NetworkError, AddLInkAccountOtpUseCaseParams, bool> {
  final CliqRepository _cliqRepository;

  AddLInkAccountOtpUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required AddLInkAccountOtpUseCaseParams params}) {
    return _cliqRepository.addLinkAccountOtp(
        aliasId: params.aliasId,
        linkType: params.linkType,
        accountNumber: params.accountNumber,
        isAlias: params.isAlias,
        aliasValue: params.aliasValue,
        getToken: params.getToken);
  }
}

class AddLInkAccountOtpUseCaseParams extends Params {
  final String aliasId;
  final String linkType;
  final String accountNumber;
  final bool isAlias;
  final String aliasValue;

  final bool getToken;

  AddLInkAccountOtpUseCaseParams(
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
