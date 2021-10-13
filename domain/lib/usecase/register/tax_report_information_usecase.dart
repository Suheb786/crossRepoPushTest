import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class TaxReportInformationUseCase
    extends BaseUseCase<LocalError, TaxReportInformationUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required TaxReportInformationUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class TaxReportInformationUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
