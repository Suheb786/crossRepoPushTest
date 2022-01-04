import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreditCardDeliveredUseCase
    extends BaseUseCase<NetworkError, CreditCardDeliveredUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required CreditCardDeliveredUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class CreditCardDeliveredUseCaseParams extends Params {
  CreditCardDeliveredUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
