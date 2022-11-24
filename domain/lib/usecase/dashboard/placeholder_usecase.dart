import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PlaceholderUseCase extends BaseUseCase<NetworkError, PlaceholderUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required PlaceholderUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class PlaceholderUseCaseParams extends Params {
  PlaceholderUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
