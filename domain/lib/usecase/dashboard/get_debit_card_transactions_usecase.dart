import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
import 'package:domain/repository/dashboard/dashboard_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetDebitCardTransactionsUseCase extends BaseUseCase<NetworkError,
    GetDebitCardTransactionsUseCaseParams, GetTransactionsResponse> {
  final DashboardRepository _repository;

  GetDebitCardTransactionsUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetTransactionsResponse>> execute(
      {required GetDebitCardTransactionsUseCaseParams params}) {
    return _repository.getDebitCardTransactions();
  }
}

class GetDebitCardTransactionsUseCaseParams extends Params {
  GetDebitCardTransactionsUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
