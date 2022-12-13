import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAccountByCustomerIDUseCase
    extends BaseUseCase<NetworkError, GetAccountByCustomerIDUseCaseParams, bool> {
  final CliqRepository _cliqRepository;

  GetAccountByCustomerIDUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required GetAccountByCustomerIDUseCaseParams params}) {
    return _cliqRepository.getAccountByCustomerID(GetToken: params.GetToken);
  }
}

class GetAccountByCustomerIDUseCaseParams extends Params {
  final bool GetToken;

  GetAccountByCustomerIDUseCaseParams(this.GetToken);

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
