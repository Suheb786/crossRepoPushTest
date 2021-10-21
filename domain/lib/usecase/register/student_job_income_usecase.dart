import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class StudentJobIncomeUseCase
    extends BaseUseCase<LocalError, StudentJobIncomeUseCaseParams, bool> {
  StudentJobIncomeUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required StudentJobIncomeUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class StudentJobIncomeUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
