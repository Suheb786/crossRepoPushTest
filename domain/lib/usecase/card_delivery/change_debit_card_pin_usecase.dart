import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ChangeDebitCardPinUseCase extends BaseUseCase<NetworkError, ChangeDebitCardPinUseCaseParams, bool> {
  final CardRepository _repository;

  ChangeDebitCardPinUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required ChangeDebitCardPinUseCaseParams params}) {
    return _repository.changeDebitCardPin(
        pin: params.pin, tokenizedPan: params.tokenizedPan, otp: params.otp, cardNumber: params.cardNumber);
  }
}

class ChangeDebitCardPinUseCaseParams extends Params {
  final String pin;
  final String otp;
  final String tokenizedPan;
  final String cardNumber;

  ChangeDebitCardPinUseCaseParams(
      {this.pin = "", this.tokenizedPan = "", this.otp = "", required this.cardNumber});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
