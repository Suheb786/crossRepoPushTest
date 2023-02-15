import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/get_account_by_customer_id/get_account_by_customer_id.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAccountByCustomerIDUseCase
    extends BaseUseCase<NetworkError, GetAccountByCustomerIDUseCaseParams, List<GetAccountByCustomerId>> {
  final CliqRepository _cliqRepository;

  GetAccountByCustomerIDUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, List<GetAccountByCustomerId>>> execute(
      {required GetAccountByCustomerIDUseCaseParams params}) {
    return _cliqRepository.getAccountByCustomerID();
  }
}

class GetAccountByCustomerIDUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
