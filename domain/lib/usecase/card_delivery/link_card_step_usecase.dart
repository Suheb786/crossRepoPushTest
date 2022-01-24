import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class LinkCardStepUseCase
    extends BaseUseCase<NetworkError, LinkCardStepUseCaseParams, bool> {
  final CardRepository _cardRepository;

  LinkCardStepUseCase(this._cardRepository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required LinkCardStepUseCaseParams params}) {
    return _cardRepository.linkCardStep(
        cardId: params.cardId, accountNumber: params.accountNumber);
  }
}

class LinkCardStepUseCaseParams extends Params {
  final String cardId;
  final String accountNumber;

  LinkCardStepUseCaseParams(
      {required this.cardId, required this.accountNumber});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
