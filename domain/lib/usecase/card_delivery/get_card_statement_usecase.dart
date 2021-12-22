import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/card_statement_response.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCardStatementUseCase extends BaseUseCase<NetworkError,
    GetCardStatementUseCaseParams, CardStatementResponse> {
  final CardRepository _repository;

  GetCardStatementUseCase(this._repository);

  @override
  Future<Either<NetworkError, CardStatementResponse>> execute(
      {required GetCardStatementUseCaseParams params}) {
    return _repository.getDebitCardStatement( params.noOfDays);
  }
}

class GetCardStatementUseCaseParams extends Params {
  int noOfDays;

  GetCardStatementUseCaseParams({required this.noOfDays});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
