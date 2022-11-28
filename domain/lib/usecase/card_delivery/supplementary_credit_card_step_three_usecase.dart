import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SupplementaryCreditCardStepThreeUseCase
    extends BaseUseCase<NetworkError, SupplementaryCreditCardStepThreeUseCaseParams, bool> {
  final CardRepository _repository;

  SupplementaryCreditCardStepThreeUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required SupplementaryCreditCardStepThreeUseCaseParams params}) {
    return _repository.supplementaryCreditCardStepThree(
        primaryCardId: params.primaryCardId!,
        secondaryCardId: params.secondaryCardId!,
        accountNumber: params.accountNumber!);
  }
}

class SupplementaryCreditCardStepThreeUseCaseParams extends Params {
  String? primaryCardId;
  String? secondaryCardId;
  String? accountNumber;

  SupplementaryCreditCardStepThreeUseCaseParams(
      {this.primaryCardId, this.secondaryCardId, this.accountNumber});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
