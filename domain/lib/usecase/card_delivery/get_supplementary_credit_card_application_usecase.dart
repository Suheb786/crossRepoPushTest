import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/supplementary_credit_card/supplementary_credit_card_application_response.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetSupplementaryCreditCardApplicationUseCase extends BaseUseCase<NetworkError,
    GetSupplementaryCreditCardApplicationUseCaseParams, SupplementaryCreditCardApplicationResponse> {
  final CardRepository _repository;

  GetSupplementaryCreditCardApplicationUseCase(this._repository);

  @override
  Future<Either<NetworkError, SupplementaryCreditCardApplicationResponse>> execute(
      {required GetSupplementaryCreditCardApplicationUseCaseParams params}) {
    return _repository.getSupplementaryCreditCardApplication(primaryCard: params.primaryCard!);
  }
}

class GetSupplementaryCreditCardApplicationUseCaseParams extends Params {
  String? primaryCard;

  GetSupplementaryCreditCardApplicationUseCaseParams({this.primaryCard});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
