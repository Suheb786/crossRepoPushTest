import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ReviewApplicationUseCase
    extends BaseUseCase<LocalError, ReviewApplicationUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required ReviewApplicationUseCaseParams params}) {
    return Future.value(Right(false));
  }
}

class ReviewApplicationUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
