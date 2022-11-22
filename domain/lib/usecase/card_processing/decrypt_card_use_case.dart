import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/card_processing/card_processing_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DecryptCardUseCase extends BaseUseCase<LocalError, DecryptCardUseCaseParams, String> {
  final CardProcessingRepository _repository;

  DecryptCardUseCase(this._repository);

  @override
  Future<Either<LocalError, String>> execute({required DecryptCardUseCaseParams params}) {
    return _repository.decryptCard(cardNo: params.cardNumber);
  }
}

class DecryptCardUseCaseParams extends Params {
  final String cardNumber;

  DecryptCardUseCaseParams({required this.cardNumber});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
