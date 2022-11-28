import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UnFreezeCreditCardUseCase extends BaseUseCase<NetworkError, UnFreezeCreditCardUseCaseParams, bool> {
  final CardRepository _repository;

  UnFreezeCreditCardUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required UnFreezeCreditCardUseCaseParams params}) {
    return _repository.unFreezeCreditCard(cardId: params.cardId);
  }
}

class UnFreezeCreditCardUseCaseParams extends Params {
  final String cardId;

  UnFreezeCreditCardUseCaseParams({required this.cardId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
