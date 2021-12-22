import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestAmountFromContactSuccessUseCase extends BaseUseCase<NetworkError,
    RequestAmountFromContactSuccessUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required RequestAmountFromContactSuccessUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class RequestAmountFromContactSuccessUseCaseParams extends Params {
  RequestAmountFromContactSuccessUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
