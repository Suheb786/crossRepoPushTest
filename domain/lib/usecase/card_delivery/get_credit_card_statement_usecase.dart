import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCreditCardStatementUseCase extends BaseUseCase<NetworkError,
    GetCreditCardStatementUseCaseParams, bool> {
  final CardRepository _repository;

  GetCreditCardStatementUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required GetCreditCardStatementUseCaseParams params}) {
    return _repository.getCreditCardStatement();
  }
}

class GetCreditCardStatementUseCaseParams extends Params {
  int noOfDays;

  GetCreditCardStatementUseCaseParams({required this.noOfDays});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
