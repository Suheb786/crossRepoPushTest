import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class TransferUseCase
    extends BaseUseCase<NetworkError, TransferUseCaseParams, bool> {
  final PaymentRepository _repository;

  TransferUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required TransferUseCaseParams params}) {
    return _repository.transfer(
        params.beneficiaryId!,
        params.transferType!,
        params.beneficiaryImage!,
        params.isFriend!,
        params.toAmount!,
        params.localEq!,
        params.memo!,
        params.toAccount!);
  }
}

class TransferUseCaseParams extends Params {
  final String? beneficiaryId;
  final String? transferType;
  final String? beneficiaryImage;
  final bool? isFriend;
  final num? toAmount;
  final num? localEq;
  final String? memo;
  final String? toAccount;

  TransferUseCaseParams(
      {this.beneficiaryId,
      this.transferType,
      this.beneficiaryImage,
      this.isFriend,
      this.toAmount,
      this.localEq,
      this.memo,
      this.toAccount});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
