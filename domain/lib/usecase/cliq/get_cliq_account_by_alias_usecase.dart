import 'package:domain/error/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCliqAccountByAliasUseCase
    extends BaseUseCase<NetworkError, GetCliqAccountByAliasParams, bool> {
  final CliqRepository _cliqRepository;

  GetCliqAccountByAliasUseCase(this._cliqRepository);
  @override
  Future<Either<NetworkError, bool>> execute(
      {required GetCliqAccountByAliasParams params}) {
    return _cliqRepository.getCliqAccountByAlias(
        alias: params.alias,
        mobileNo: params.mobileNo,
        iban: params.iban,
        accountNo: params.accountNo,
        swiftCode: params.swiftCode,
        bankCountry: params.bankCountry,
        transferType: params.transferType,
        cliqType: params.cliqType,
        getToken: params.getToken);
  }
}

class GetCliqAccountByAliasParams extends Params {
  final String alias;
  final String mobileNo;
  final String iban;
  final String accountNo;
  final String swiftCode;
  final String bankCountry;
  final String transferType;
  final String cliqType;
  final bool getToken;

  GetCliqAccountByAliasParams(
      {required this.alias,
      required this.mobileNo,
      required this.iban,
      required this.accountNo,
      required this.swiftCode,
      required this.bankCountry,
      required this.transferType,
      required this.cliqType,
      required this.getToken});
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
