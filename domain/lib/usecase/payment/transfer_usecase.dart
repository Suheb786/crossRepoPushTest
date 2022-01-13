import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class TransferUseCase extends BaseUseCase<NetworkError, TransferUseCaseParams,
    TransferSuccessResponse> {
  final PaymentRepository _repository;

  TransferUseCase(this._repository);

  @override
  Future<Either<NetworkError, TransferSuccessResponse>> execute(
      {required TransferUseCaseParams params}) {
    return _repository.transfer(
        transferType: params.transferType!,
        toAmount: params.toAmount!,
        toAccount: params.toAccount!,
        localEq: params.localEq!,
        beneficiaryImage: params.beneficiaryImage!,
        beneficiaryId: params.beneficiaryId!,
        otpCode: params.otpCode!,
        isFriend: params.isFriend!,
        memo: params.memo!,
        nickName: params.nickName!);
  }
}

class TransferUseCaseParams extends Params {
  final String? beneficiaryId;
  final String? otpCode;
  final String? transferType;
  final String? beneficiaryImage;
  final bool? isFriend;
  final num? toAmount;
  final num? localEq;
  final String? memo;
  final String? toAccount;
  final String? nickName;

  TransferUseCaseParams(
      {this.beneficiaryId,
      this.otpCode,
      this.transferType,
      this.beneficiaryImage,
      this.isFriend,
      this.toAmount,
      this.localEq,
      this.memo,
      this.nickName,
      this.toAccount});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
