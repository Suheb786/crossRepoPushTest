import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CardIssuanceUseCase extends BaseUseCase<NetworkError, CardIssuanceUseCaseParams, CardIssuanceDetails> {
  final CardRepository _repository;

  CardIssuanceUseCase(this._repository);

  @override
  Future<Either<NetworkError, CardIssuanceDetails>> execute({required CardIssuanceUseCaseParams params}) {
    return _repository.getCardIssuanceDetails();
  }
}

class CardIssuanceUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
