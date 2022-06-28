import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RemoveOrReapplySuppDebitCardWithResponseUseCase extends BaseUseCase<NetworkError,
    RemoveOrReapplySuppDebitCardWithResponseUseCaseParams, CardIssuanceDetails> {
  final CardRepository _repository;

  RemoveOrReapplySuppDebitCardWithResponseUseCase(this._repository);

  @override
  Future<Either<NetworkError, CardIssuanceDetails>> execute(
      {required RemoveOrReapplySuppDebitCardWithResponseUseCaseParams params}) {
    return _repository.removeOrReApplySupplementaryDebitCardWithResponse(
        status: params.status, tokenizedPan: params.tokenizedPan, reApply: params.reApply);
  }
}

class RemoveOrReapplySuppDebitCardWithResponseUseCaseParams extends Params {
  final String status;
  final String tokenizedPan;
  final bool reApply;

  RemoveOrReapplySuppDebitCardWithResponseUseCaseParams(
      {required this.status, required this.tokenizedPan, required this.reApply});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
