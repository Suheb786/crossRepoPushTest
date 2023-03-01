import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestMoneyUseCase extends BaseUseCase<NetworkError, RequestMoneyUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required RequestMoneyUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class RequestMoneyUseCaseParams extends Params {
  String? amount;

  RequestMoneyUseCaseParams({this.amount});

  @override
  Either<AppError, bool> verify() {
    if (double.parse(amount!) <= 0) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.ZERO_AMOUNT, cause: Exception()));
    }
    return Right(true);
  }
}
