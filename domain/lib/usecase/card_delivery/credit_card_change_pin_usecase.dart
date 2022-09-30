import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreditCardChangePinUseCase extends BaseUseCase<NetworkError, CreditCardChangePinUseCaseParams, bool> {
  final CardRepository _repository;

  CreditCardChangePinUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required CreditCardChangePinUseCaseParams params}) {
    return _repository.changeCreditCardPin(
        cardCode: params.cardCode, cardNumber: params.cardNumber, pin: params.pin, otp: params.otp);
  }
}

class CreditCardChangePinUseCaseParams extends Params {
  final String cardCode;
  final String pin;
  final String cardNumber;
  final String otp;

  CreditCardChangePinUseCaseParams(
      {required this.cardCode, required this.pin, required this.cardNumber, required this.otp});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
