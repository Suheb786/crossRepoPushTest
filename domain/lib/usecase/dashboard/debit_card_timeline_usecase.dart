import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DebitCardTimeLineUseCase extends BaseUseCase<NetworkError, DebitCardTimeLineUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required DebitCardTimeLineUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class DebitCardTimeLineUseCaseParams extends Params {
  DebitCardTimeLineUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
