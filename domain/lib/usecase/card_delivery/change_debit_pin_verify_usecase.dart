import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ChangeDebitPinVerifyUseCase extends BaseUseCase<NetworkError, ChangeDebitPinVerifyUseCaseParams, bool> {
  final CardRepository _repository;

  ChangeDebitPinVerifyUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required ChangeDebitPinVerifyUseCaseParams params}) {
    return _repository.changePinVerify();
  }
}

class ChangeDebitPinVerifyUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
