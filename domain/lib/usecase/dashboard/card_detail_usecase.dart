import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CardDetailUseCase
    extends BaseUseCase<NetworkError, CardDetailUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required CardDetailUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class CardDetailUseCaseParams extends Params {
  CardDetailUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
