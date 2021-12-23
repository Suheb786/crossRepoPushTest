import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetDebitYearsUseCase
    extends BaseUseCase<NetworkError, GetDebitYearsUseCaseParams, bool> {
  final CardRepository _repository;

  GetDebitYearsUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required GetDebitYearsUseCaseParams params}) {
    return _repository.getDebitYears();
  }
}

class GetDebitYearsUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
