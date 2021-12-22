import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ConfirmCreditCardDeliveryUseCase extends BaseUseCase<NetworkError,
    ConfirmCreditCardDeliveryUseCaseParams, bool> {
  final CardRepository _repository;

  ConfirmCreditCardDeliveryUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required ConfirmCreditCardDeliveryUseCaseParams params}) {
    return _repository.confirmCreditCardDelivery();
  }
}

class ConfirmCreditCardDeliveryUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
