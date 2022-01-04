import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DebitCardDeliveredUseCase
    extends BaseUseCase<NetworkError, DebitCardDeliveredUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required DebitCardDeliveredUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class DebitCardDeliveredUseCaseParams extends Params {
  DebitCardDeliveredUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
