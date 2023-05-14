import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetContactsUseCase extends BaseUseCase<NetworkError, GetContactsUseCaseParams, bool> {
  GetContactsUseCase();

  @override
  Future<Either<NetworkError, bool>> execute({required GetContactsUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class GetContactsUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
