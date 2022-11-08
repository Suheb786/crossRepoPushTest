import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/apple_pay/apple_pay_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EnrollCardUseCase extends BaseUseCase<NetworkError, EnrollCardUseCaseParams, bool> {
  final ApplePayRepository _repository;

  EnrollCardUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required EnrollCardUseCaseParams params}) {
    return _repository.enrollCards(
        cardId: params.cardId, cardType: params.walletId, walletId: params.cardType);
  }
}

class EnrollCardUseCaseParams extends Params {
  String cardId;
  String walletId;
  String cardType;

  EnrollCardUseCaseParams({this.cardId = '', this.walletId = '', this.cardType = ''});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
