import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/get_debit_years_response.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCreditYearsUseCase
    extends BaseUseCase<NetworkError, GetCreditYearsUseCaseParams, GetDebitYearsResponse> {
  final CardRepository _repository;

  GetCreditYearsUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetDebitYearsResponse>> execute({required GetCreditYearsUseCaseParams params}) {
    return _repository.getCreditYears();
  }
}

class GetCreditYearsUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
