import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCliqAccountByAliasUseCase extends BaseUseCase<NetworkError, GetCliqAccountByAliasParams, bool> {
  final CliqRepository _cliqRepository;

  GetCliqAccountByAliasUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required GetCliqAccountByAliasParams params}) {
    return _cliqRepository.getCliqAccountByAlias(
        GetToken: params.GetToken,
        CustID: params.CustID,
        Currency: params.Currency,
        type: params.type,
        value: params.value);
  }
}

class GetCliqAccountByAliasParams extends Params {
  final String type;
  final String value;
  final String Currency;
  final String CustID;
  final bool GetToken;

  GetCliqAccountByAliasParams(
      {required this.type,
      required this.value,
      required this.Currency,
      required this.CustID,
      required this.GetToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
