import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SupplementaryCreditCardStepTwoUseCase
    extends BaseUseCase<NetworkError, SupplementaryCreditCardStepTwoUseCaseParams, bool> {
  final CardRepository _repository;

  SupplementaryCreditCardStepTwoUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required SupplementaryCreditCardStepTwoUseCaseParams params}) {
    return _repository.supplementaryCreditCardStepTwo(
        primaryCardId: params.primaryCardId!, secondaryCardId: params.secondaryCardId!);
  }
}

class SupplementaryCreditCardStepTwoUseCaseParams extends Params {
  String? primaryCardId;
  String? secondaryCardId;

  SupplementaryCreditCardStepTwoUseCaseParams({this.primaryCardId, this.secondaryCardId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
