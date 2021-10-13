import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class TaxationDetailsUseCase
    extends BaseUseCase<LocalError, TaxationDetailsUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required TaxationDetailsUseCaseParams params}) {
    return Future.value(Right(false));
  }
}

class TaxationDetailsUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
