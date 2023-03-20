import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/create_cliq_id/confirm_create_cliq_id.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ConfirmCreateCliqIdUseCase
    extends BaseUseCase<NetworkError, ConfirmCreateCliqIdParams, ConfirmCreateCliqId> {
  final CliqRepository _cliqRepository;

  ConfirmCreateCliqIdUseCase(this._cliqRepository);
  @override
  Future<Either<NetworkError, ConfirmCreateCliqId>> execute({required ConfirmCreateCliqIdParams params}) {
    return _cliqRepository.confirmCreateCLidID(
        accountNumber: params.accountNumber,
        isAlias: params.isAlias,
        aliasValue: params.aliasValue,
        otpCode: params.otpCode,
        getToken: params.getToken,
        isSetDefault: params.isSetDefault);
  }
}

class ConfirmCreateCliqIdParams extends Params {
  final String accountNumber;
  final bool isAlias;
  final String aliasValue;
  final String otpCode;
  final bool getToken;
  final bool isSetDefault;

  ConfirmCreateCliqIdParams(
      {required this.accountNumber,
      required this.isAlias,
      required this.aliasValue,
      required this.otpCode,
      required this.getToken,
      required this.isSetDefault});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
