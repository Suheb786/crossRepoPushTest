import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/get_loan_values/get_loan_values_response.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetLoanValueUseCase extends BaseUseCase<NetworkError,
    GetLoanValueUseCaseParams, GetLoanValuesResponse> {
  final CardRepository _cardRepository;

  GetLoanValueUseCase(this._cardRepository);

  @override
  Future<Either<NetworkError, GetLoanValuesResponse>> execute(
      {required GetLoanValueUseCaseParams params}) {
    return _cardRepository.getLoanValues();
  }
}

class GetLoanValueUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
