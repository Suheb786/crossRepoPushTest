import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UpdateSettlementUseCase extends BaseUseCase<NetworkError, UpdateSettlementUseCaseParams, bool> {
  final CardRepository _cardRepository;

  UpdateSettlementUseCase(this._cardRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required UpdateSettlementUseCaseParams params}) {
    return _cardRepository.updateSettlement(params: params);
  }
}

class UpdateSettlementUseCaseParams extends Params {
  final String? cardId;
  final int? rate;

  UpdateSettlementUseCaseParams({this.cardId, this.rate});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
