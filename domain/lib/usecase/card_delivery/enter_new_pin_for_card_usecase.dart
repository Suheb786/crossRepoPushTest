import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class EnterNewPinForCardUseCase
    extends BaseUseCase<BaseError, EnterNewPinForCardUseCaseParams, bool> {
  final CardRepository _repository;

  EnterNewPinForCardUseCase(this._repository);

  @override
  Future<Either<BaseError, bool>> execute(
      {required EnterNewPinForCardUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EnterNewPinForCardUseCaseParams extends Params {
  final String pin;
  final String confirmPin;
  final CardType cardType;

  EnterNewPinForCardUseCaseParams(
      {required this.pin, required this.confirmPin, required this.cardType});

  @override
  Either<AppError, bool> verify() {
    if (pin.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_PIN,
          cause: Exception()));
    } else if (confirmPin.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_CONFIRM_PIN,
          cause: Exception()));
    } else if (!Validator.isEqual(pin, confirmPin)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.PIN_NOT_MATCH,
          cause: Exception()));
    }
    return Right(true);
  }
}
