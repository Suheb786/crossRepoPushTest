import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/get_credit_card_relationship/credit_card_relationship_respponse.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCreditCardRelationshipListUseCase extends BaseUseCase<
    NetworkError,
    GetCreditCardRelationshipListUseCaseParams,
    CreditCardRelationshipResponse> {
  final CardRepository _repository;

  GetCreditCardRelationshipListUseCase(this._repository);

  @override
  Future<Either<NetworkError, CreditCardRelationshipResponse>> execute(
      {required GetCreditCardRelationshipListUseCaseParams params}) {
    return _repository.getCreditCardRelationShipList(cardId: params.cardId!);
  }
}

class GetCreditCardRelationshipListUseCaseParams extends Params {
  String? cardId;

  GetCreditCardRelationshipListUseCaseParams({this.cardId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
