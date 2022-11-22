import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ConfirmCardDeliveryUseCase extends BaseUseCase<NetworkError, ConfirmCardDeliveryUseCaseParams, bool> {
  final CardRepository _repository;

  ConfirmCardDeliveryUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required ConfirmCardDeliveryUseCaseParams params}) {
    return _repository.confirmCardDelivery();
  }
}

class ConfirmCardDeliveryUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
