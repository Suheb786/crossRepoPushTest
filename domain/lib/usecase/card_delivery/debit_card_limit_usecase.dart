import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/debit_card/debit_card_limit_response.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DebitCardLimitUseCase extends BaseUseCase<NetworkError,
    DebitCardLimitUseCaseParams, DebitCardLimitResponse> {
  final CardRepository _repository;

  DebitCardLimitUseCase(this._repository);

  @override
  Future<Either<NetworkError, DebitCardLimitResponse>> execute(
      {required DebitCardLimitUseCaseParams params}) {
    return _repository.getDebitCardLimit();
  }
}

class DebitCardLimitUseCaseParams extends Params {
  DebitCardLimitUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
