import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/usecase/cliq/edit_cliq_id_usecase.dart';

class GetAliasUsecase
    extends BaseUseCase<NetworkError, GetAliasUseCaseParams, GetAlias> {
  final CliqRepository _cliqRepository;

  GetAliasUsecase(this._cliqRepository);
  @override
  Future<Either<NetworkError, GetAlias>> execute(
      {required GetAliasUseCaseParams params}) {
    return _cliqRepository.getAlias(getToken: params.getToken);
  }
}

class GetAliasUseCaseParams extends Params {
  final bool getToken;

  GetAliasUseCaseParams({required this.getToken});
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
