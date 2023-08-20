import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/statement_type.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/card_statement_response.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCardStatementUseCase
    extends BaseUseCase<NetworkError, GetCardStatementUseCaseParams, CardStatementResponse> {
  final CardRepository _repository;

  GetCardStatementUseCase(this._repository);

  @override
  Future<Either<NetworkError, CardStatementResponse>> execute(
      {required GetCardStatementUseCaseParams params}) {
    return params.statementType == StatementType.Debit
        ? _repository.getDebitCardStatement(params.monthYear)
        : _repository.getCreditCardStatement(
            params.monthYear, params.cardId, params.secureCode, params.issuedFromCms);
  }
}

class GetCardStatementUseCaseParams extends Params {
  String monthYear;
  String? cardId;
  StatementType statementType;
  String secureCode;
  bool? issuedFromCms;

  GetCardStatementUseCaseParams(
      {required this.monthYear,
      required this.statementType,
      required this.cardId,
      required this.secureCode,
      required this.issuedFromCms});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
