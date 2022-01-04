import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CardTransactionUseCase
    extends BaseUseCase<NetworkError, CardTransactionUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required CardTransactionUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class CardTransactionUseCaseParams extends Params {
  CardTransactionUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
