import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCreditCardTransactionsUseCase extends BaseUseCase<NetworkError,
    GetCreditCardTransactionsUseCaseParams, GetTransactionsResponse> {
  final CardRepository _repository;

  GetCreditCardTransactionsUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetTransactionsResponse>> execute(
      {required GetCreditCardTransactionsUseCaseParams params}) {
    return _repository.getCreditCardTransactions();
  }
}

class GetCreditCardTransactionsUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
