import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CancelCreditCardUseCase
    extends BaseUseCase<NetworkError, CancelCreditCardUseCaseParams, bool> {
  final CardRepository _repository;

  CancelCreditCardUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required CancelCreditCardUseCaseParams params}) {
    return _repository.cancelCreditCard(reason: params.reason);
  }
}

class CancelCreditCardUseCaseParams extends Params {
  final String reason;

  CancelCreditCardUseCaseParams({this.reason: ""});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
