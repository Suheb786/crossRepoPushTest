import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestAmountFromContactUseCase extends BaseUseCase<NetworkError,
    RequestAmountFromContactUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required RequestAmountFromContactUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class RequestAmountFromContactUseCaseParams extends Params {
  RequestAmountFromContactUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
