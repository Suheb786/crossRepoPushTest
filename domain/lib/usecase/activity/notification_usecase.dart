import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class NotificationUseCase
    extends BaseUseCase<NetworkError, NotificationUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required NotificationUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class NotificationUseCaseParams extends Params {
  NotificationUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
