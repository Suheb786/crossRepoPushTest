import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CardDeliveredUseCase
    extends BaseUseCase<NetworkError, CardDeliveredUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required CardDeliveredUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class CardDeliveredUseCaseParams extends Params {
  CardDeliveredUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
