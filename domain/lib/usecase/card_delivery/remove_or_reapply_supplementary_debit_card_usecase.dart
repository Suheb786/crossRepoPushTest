import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RemoveOrReapplySupplementaryDebitCardUseCase
    extends BaseUseCase<NetworkError, RemoveOrReApplySupplementaryDebitCardParams, bool> {
  final CardRepository _repository;

  RemoveOrReapplySupplementaryDebitCardUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required RemoveOrReApplySupplementaryDebitCardParams params}) {
    return _repository.removeOrReApplySupplementaryDebitCard(
        status: params.status, tokenizedPan: params.tokenizedPan, reApply: params.reApply);
  }
}

class RemoveOrReApplySupplementaryDebitCardParams extends Params {
  final String status;
  final String tokenizedPan;
  final bool reApply;

  RemoveOrReApplySupplementaryDebitCardParams(
      {required this.status, required this.tokenizedPan, required this.reApply});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
