import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DownloadCardTransactionUseCase extends BaseUseCase<NetworkError,
    DownloadCardTransactionUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required DownloadCardTransactionUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class DownloadCardTransactionUseCaseParams extends Params {
  DownloadCardTransactionUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
