import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreditCardPinUnblockUseCase
    extends BaseUseCase<NetworkError, CreditCardPinUnblockUseCaseParams, bool> {
  final CardRepository _repository;

  CreditCardPinUnblockUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required CreditCardPinUnblockUseCaseParams params}) {
    return _repository.creditCardPinUnblock();
  }
}

class CreditCardPinUnblockUseCaseParams extends Params {
  CreditCardPinUnblockUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
