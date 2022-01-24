import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FreezeCreditCardUseCase
    extends BaseUseCase<NetworkError, FreezeCreditCardUseCaseParams, bool> {
  final CardRepository _repository;

  FreezeCreditCardUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required FreezeCreditCardUseCaseParams params}) {
    return _repository.freezeCreditCard(cardId: params.cardId);
  }
}

class FreezeCreditCardUseCaseParams extends Params {
  final String cardId;

  FreezeCreditCardUseCaseParams({required this.cardId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
