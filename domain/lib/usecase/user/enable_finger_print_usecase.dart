import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EnableFingerPrintUseCase
    extends BaseUseCase<NetworkError, EnableFingerPrintUseCaseParams, bool> {
  final UserRepository _repository;

  EnableFingerPrintUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required EnableFingerPrintUseCaseParams params}) {
    return _repository.enableFingerPrint(cipher: params.cipher);
  }
}

class EnableFingerPrintUseCaseParams extends Params {
  final String cipher;

  EnableFingerPrintUseCaseParams({required this.cipher});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
