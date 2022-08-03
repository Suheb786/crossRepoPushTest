import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ProcessLoanStepUseCase extends BaseUseCase<NetworkError, ProcessLoanStepUseCaseParams, bool> {
  final CardRepository _cardRepository;

  ProcessLoanStepUseCase(this._cardRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required ProcessLoanStepUseCaseParams params}) {
    return _cardRepository.processLoanRequest(loanValueId: params.loanValueId!, cardId: params.cardId!);
  }
}

class ProcessLoanStepUseCaseParams extends Params {
  String? cardId;
  num? loanValueId;

  ProcessLoanStepUseCaseParams({this.cardId = '', this.loanValueId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
