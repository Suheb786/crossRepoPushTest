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
    return _repository.unFreezeDebitCard();
  }
}

class UnFreezeDebitCardUseCaseParams extends Params {
  UnFreezeDebitCardUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
