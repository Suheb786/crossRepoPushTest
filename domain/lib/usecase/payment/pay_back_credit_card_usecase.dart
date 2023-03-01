import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PayBackCreditCardUseCase extends BaseUseCase<NetworkError, PayBackCreditCardUseCaseParams, bool> {
  final PaymentRepository _repository;

  PayBackCreditCardUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required PayBackCreditCardUseCaseParams params}) {
    return _repository.payBackCreditCard(secureCode: params.secureCode, payBackAmount: params.payBackAmount);
  }
}

class PayBackCreditCardUseCaseParams extends Params {
  String? secureCode;
  String? payBackAmount;

  PayBackCreditCardUseCaseParams({this.secureCode, this.payBackAmount});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
