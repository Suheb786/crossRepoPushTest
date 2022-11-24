import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/card_processing/card_processing_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GenerateBlockPinUseCase extends BaseUseCase<LocalError, GenerateBlockPinUseCaseParams, String> {
  final CardProcessingRepository _repository;

  GenerateBlockPinUseCase(this._repository);

  @override
  Future<Either<LocalError, String>> execute({
    required GenerateBlockPinUseCaseParams params,
  }) {
    return _repository.generateBlockPin(
      cardNo: params.cardNumber,
      pinCode: params.pinCode,
    );
  }
}

class GenerateBlockPinUseCaseParams extends Params {
  final String cardNumber;
  final String pinCode;

  GenerateBlockPinUseCaseParams({required this.cardNumber, required this.pinCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
