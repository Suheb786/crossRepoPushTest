import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestMoneyActivityUseCase extends BaseUseCase<NetworkError, RequestMoneyActivityParams, bool> {
  final CliqRepository _cliqRepository;

  RequestMoneyActivityUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required RequestMoneyActivityParams params}) {
    return _cliqRepository.requestMoneyActivity(getToken: params.getToken);
  }
}

class RequestMoneyActivityParams extends Params {
  final bool getToken;

  RequestMoneyActivityParams(this.getToken);

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
