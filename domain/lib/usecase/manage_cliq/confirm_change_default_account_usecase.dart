import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ConfirmChangeDefaultAccountUseCase extends BaseUseCase<NetworkError, ChangeDefaultAccountParams, bool> {
  final CliqRepository _cliqRepository;

  ConfirmChangeDefaultAccountUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required ChangeDefaultAccountParams params}) {
    return _cliqRepository.confirmChangeDefaultAccount(GetToken: params.GetToken);
  }
}

class ChangeDefaultAccountParams extends Params {
  final bool GetToken;

  ChangeDefaultAccountParams({required this.GetToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
