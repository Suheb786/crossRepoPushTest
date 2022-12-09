import 'package:domain/error/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCustomerByAccountUseCase
    extends BaseUseCase<NetworkError, GetCustomerByAccountUseCaseParams, bool> {
  final CliqRepository _cliqRepository;

  GetCustomerByAccountUseCase(this._cliqRepository);
  @override
  Future<Either<NetworkError, bool>> execute(
      {required GetCustomerByAccountUseCaseParams params}) {
    return _cliqRepository.getCustomerByAccount(
        accountCode: params.accountCode,
        CustID: params.CustID,
        GetToken: params.GetToken);
  }
}

class GetCustomerByAccountUseCaseParams extends Params {
  final String accountCode;
  final String CustID;
  final bool GetToken;

  GetCustomerByAccountUseCaseParams(
      {required this.accountCode,
      required this.CustID,
      required this.GetToken});
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
