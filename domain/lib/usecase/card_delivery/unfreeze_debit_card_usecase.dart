import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UnFreezeDebitCardUseCase
    extends BaseUseCase<NetworkError, UnFreezeDebitCardUseCaseParams, bool> {
  final CardRepository _repository;

  UnFreezeDebitCardUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required UnFreezeDebitCardUseCaseParams params}) {
    return _repository.unFreezeDebitCard(
        status: params.status, tokenizedPan: params.tokenizedPan);
  }
}

class UnFreezeDebitCardUseCaseParams extends Params {
  final String status;
  final String tokenizedPan;

  UnFreezeDebitCardUseCaseParams(
      {required this.status, required this.tokenizedPan});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
