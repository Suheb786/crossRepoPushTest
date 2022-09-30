import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestPhysicalDebitCardUseCase
    extends BaseUseCase<NetworkError, RequestPhysicalDebitCardUseCaseParams, bool> {
  final CardRepository _repository;

  RequestPhysicalDebitCardUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required RequestPhysicalDebitCardUseCaseParams params}) {
    return _repository.requestPhysicalDebitCard(tokenizedPan: params.tokenizedPan);
  }
}

class RequestPhysicalDebitCardUseCaseParams extends Params {
  final String tokenizedPan;

  RequestPhysicalDebitCardUseCaseParams({required this.tokenizedPan});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
