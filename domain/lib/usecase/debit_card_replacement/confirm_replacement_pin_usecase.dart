import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ConfirmReplacementPinUseCase
    extends BaseUseCase<NetworkError, ConfirmReplacementPinUseCaseParams, bool> {
  final CardRepository _repository;

  ConfirmReplacementPinUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required ConfirmReplacementPinUseCaseParams params}) {
    return _repository.setCardPin(params.currentPin, params.cardNumber);
  }
}

class ConfirmReplacementPinUseCaseParams extends Params {
  final String currentPin;
  final String previousPin;
  final String cardNumber;

  ConfirmReplacementPinUseCaseParams({
    required this.currentPin,
    required this.previousPin,
    required this.cardNumber,
  });

  @override
  Either<AppError, bool> verify() {
    if (currentPin.isEmpty) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_PIN, cause: Exception()));
    } else if (currentPin.length < 4) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_PIN_LENGTH, cause: Exception()));
    } else if (!(currentPin == previousPin)) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.PIN_NOT_MATCH, cause: Exception()));
    }
    return Right(true);
  }
}
