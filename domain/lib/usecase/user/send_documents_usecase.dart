import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SendDocumentsUseCase extends BaseUseCase<LocalError, SendDocumentsUseCaseParams, bool> {
  SendDocumentsUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required SendDocumentsUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class SendDocumentsUseCaseParams extends Params {
  final String? incomeProof;
  final String? addressProof;

  SendDocumentsUseCaseParams({
    this.incomeProof,
    this.addressProof,
  });

  @override
  Either<AppError, bool> verify() {
    //To do: change validation msg
    return Right(true);
  }
}
