import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreditCardCallStatusUpdateUseCase
    extends BaseUseCase<NetworkError, CreditCardCallStatusUpdateUseCaseParams, bool> {
  final CardRepository _cardRepository;

  CreditCardCallStatusUpdateUseCase(this._cardRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required CreditCardCallStatusUpdateUseCaseParams params}) {
    return _cardRepository.callStatusUpdate(cardId: params.cardId, status: params.status);
  }
}

class CreditCardCallStatusUpdateUseCaseParams extends Params {
  String? cardId;
  String? status;

  CreditCardCallStatusUpdateUseCaseParams({this.cardId, this.status});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
