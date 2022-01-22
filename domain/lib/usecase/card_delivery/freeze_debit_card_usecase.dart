import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FreezeDebitCardUseCase
    extends BaseUseCase<NetworkError, FreezeDebitCardUseCaseParams, bool> {
  final CardRepository _repository;

  FreezeDebitCardUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required FreezeDebitCardUseCaseParams params}) {
    return _repository.freezeDebitCard(
        status: params.status, tokenizedPan: params.tokenizedPan);
  }
}

class FreezeDebitCardUseCaseParams extends Params {
  final String status;
  final String tokenizedPan;

  FreezeDebitCardUseCaseParams(
      {required this.status, required this.tokenizedPan});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
