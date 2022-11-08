import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/apple_pay/apple_pay_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetUserWalletDetailUseCase extends BaseUseCase<NetworkError, GetUserWalletDetailUseCaseParams, bool> {
  final ApplePayRepository _repository;

  GetUserWalletDetailUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required GetUserWalletDetailUseCaseParams params}) {
    return _repository.getUserWalletDetail();
  }
}

class GetUserWalletDetailUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
