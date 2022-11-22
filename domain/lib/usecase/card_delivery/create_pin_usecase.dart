import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreatePinUseCase extends BaseUseCase<NetworkError, CreatePinUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required CreatePinUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class CreatePinUseCaseParams extends Params {
  final String pin;

  CreatePinUseCaseParams({required this.pin});

  @override
  Either<AppError, bool> verify() {
    if (pin.isEmpty) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_PIN, cause: Exception()));
    } else if (pin.length < 4) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_PIN_LENGTH, cause: Exception()));
    }
    return Right(true);
  }
}
