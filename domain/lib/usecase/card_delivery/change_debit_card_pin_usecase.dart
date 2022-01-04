import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ChangeDebitCardPinUseCase
    extends BaseUseCase<NetworkError, ChangeDebitCardPinUseCaseParams, bool> {
  final CardRepository _repository;

  ChangeDebitCardPinUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required ChangeDebitCardPinUseCaseParams params}) {
    return _repository.changeDebitCardPin(pin: params.pin);
  }
}

class ChangeDebitCardPinUseCaseParams extends Params {
  final String pin;

  ChangeDebitCardPinUseCaseParams({this.pin: ""});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
