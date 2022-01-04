import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCardUseCase
    extends BaseUseCase<NetworkError, GetCardUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required GetCardUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class GetCardUseCaseParams extends Params {
  GetCardUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
