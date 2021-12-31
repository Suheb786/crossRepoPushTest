import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class TransferVerifyUseCase
    extends BaseUseCase<NetworkError, TransferVerifyUseCaseParams, bool> {
  final PaymentRepository _repository;

  TransferVerifyUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required TransferVerifyUseCaseParams params}) {
    return _repository.transferVerify();
  }
}

class TransferVerifyUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
