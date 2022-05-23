import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/credit_card/get_credit_card_limit_response.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCreditCardLimitUseCase extends BaseUseCase<NetworkError,
    GetCreditCardLimitUseCaseParams, GetCreditCardLimitResponse> {
  final CardRepository _repository;

  GetCreditCardLimitUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetCreditCardLimitResponse>> execute(
      {required GetCreditCardLimitUseCaseParams params}) {
    return _repository.getCreditCardLimit(secureCode: params.secureCode);
  }
}

class GetCreditCardLimitUseCaseParams extends Params {
  final String? secureCode;

  GetCreditCardLimitUseCaseParams({this.secureCode: ""});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
