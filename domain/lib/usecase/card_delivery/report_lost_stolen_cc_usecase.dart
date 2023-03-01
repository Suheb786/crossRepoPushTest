import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ReportLostStolenCCUseCase extends BaseUseCase<NetworkError, ReportLostStolenCCUseCaseParams, bool> {
  final CardRepository _repository;

  ReportLostStolenCCUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required ReportLostStolenCCUseCaseParams params}) {
    return _repository.reportLostStolenCC(params: params);
  }
}

class ReportLostStolenCCUseCaseParams extends Params {
  final String cardCode;
  final String panGenerationMode;
  final String replacementReason;

  ReportLostStolenCCUseCaseParams(
      {required this.cardCode, required this.panGenerationMode, required this.replacementReason});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
