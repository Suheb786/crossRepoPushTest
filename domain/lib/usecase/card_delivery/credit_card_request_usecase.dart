import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreditCardRequestUseCase extends BaseUseCase<NetworkError, CreditCardRequestUseCaseParams, bool> {
  final CardRepository _repository;

  CreditCardRequestUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required CreditCardRequestUseCaseParams params}) {
    return _repository.requestCreditCard(cardId: params.cardId);
  }
}

class CreditCardRequestUseCaseParams extends Params {
  final String cardId;

  CreditCardRequestUseCaseParams({this.cardId: ""});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
