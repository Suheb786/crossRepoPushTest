import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/card_statement_response.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCreditCardStatementUseCase
    extends BaseUseCase<NetworkError, GetCreditCardStatementUseCaseParams, CardStatementResponse> {
  final CardRepository _repository;

  GetCreditCardStatementUseCase(this._repository);

  @override
  Future<Either<NetworkError, CardStatementResponse>> execute(
      {required GetCreditCardStatementUseCaseParams params}) {
    return _repository.getCreditCardStatement(params.monthYear, params.cardId);
  }
}

class GetCreditCardStatementUseCaseParams extends Params {
  String monthYear;
  String? cardId;

  GetCreditCardStatementUseCaseParams({required this.monthYear, required this.cardId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
