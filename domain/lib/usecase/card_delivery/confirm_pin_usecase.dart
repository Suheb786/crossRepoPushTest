import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ConfirmPinUseCase extends BaseUseCase<NetworkError, ConfirmPinUseCaseParams, bool> {
  final CardRepository _repository;

  ConfirmPinUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required ConfirmPinUseCaseParams params}) {
    return _repository.setCardPin(params.currentPin, params.cardNumber!);
  }
}

class ConfirmPinUseCaseParams extends Params {
  final String currentPin;
  final String previousPin;
  final String? cardNumber;

  ConfirmPinUseCaseParams({required this.currentPin, required this.previousPin, this.cardNumber});

  @override
  Either<AppError, bool> verify() {
    if (currentPin.isEmpty) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_PIN, cause: Exception()));
    } else if (currentPin.length < 4) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_PIN_LENGTH, cause: Exception()));
    } else if (!(currentPin == previousPin)) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.PIN_NOT_MATCH, cause: Exception()));
    } else if (this.cardNumber!.isEmpty) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_CARD_NO, cause: Exception()));
    }
    return Right(true);
  }
}
