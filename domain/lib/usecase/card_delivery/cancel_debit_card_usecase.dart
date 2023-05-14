import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CancelDebitCardUseCase extends BaseUseCase<NetworkError, CancelDebitCardUseCaseParams, bool> {
  final CardRepository _repository;

  CancelDebitCardUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required CancelDebitCardUseCaseParams params}) {
    return _repository.cancelDebitCard(
        reason: params.status,
        status: params.status,
        tokenizedPan: params.tokenizedPan,
        cancellationReason: params.cancellationReason);
  }
}

class CancelDebitCardUseCaseParams extends Params {
  final String status;
  final String tokenizedPan;
  final String reason;
  final String cancellationReason;

  CancelDebitCardUseCaseParams(
      {this.status = "", this.tokenizedPan = "", this.reason = "", this.cancellationReason = ""});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
