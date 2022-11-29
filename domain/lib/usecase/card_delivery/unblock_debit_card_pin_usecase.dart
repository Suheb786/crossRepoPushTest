import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UnblockDebitCardPinUseCase extends BaseUseCase<NetworkError, UnblockDebitCardPinUseCaseParams, bool> {
  final CardRepository _repository;

  UnblockDebitCardPinUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required UnblockDebitCardPinUseCaseParams params}) {
    return _repository.unblockDebitCardPin(status: params.status, pin: params.pin);
  }
}

class UnblockDebitCardPinUseCaseParams extends Params {
  final String status;
  final String pin;

  UnblockDebitCardPinUseCaseParams({this.status: "", required this.pin});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
