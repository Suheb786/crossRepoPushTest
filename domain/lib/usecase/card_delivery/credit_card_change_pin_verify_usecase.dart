import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreditCardChangePinVerifyUseCase
    extends BaseUseCase<NetworkError, CreditCardChangePinVerifyUseCaseParams, bool> {
  final CardRepository _repository;

  CreditCardChangePinVerifyUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required CreditCardChangePinVerifyUseCaseParams params}) {
    return _repository.changeCreditCardPinVerify(cardCode: params.cardCode);
  }
}

class CreditCardChangePinVerifyUseCaseParams extends Params {
  final String cardCode;

  CreditCardChangePinVerifyUseCaseParams({required this.cardCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
