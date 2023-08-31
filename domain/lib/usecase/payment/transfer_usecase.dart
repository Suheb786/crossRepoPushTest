import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class TransferUseCase extends BaseUseCase<NetworkError, TransferUseCaseParams, TransferSuccessResponse> {
  final PaymentRepository _repository;

  TransferUseCase(this._repository);

  @override
  Future<Either<NetworkError, TransferSuccessResponse>> execute({required TransferUseCaseParams params}) {
    return _repository.transfer(
        transferType: params.transferType!,
        toAmount: params.toAmount!,
        toAccount: params.toAccount!,
        localEq: params.localEq!,
        beneficiaryImage: params.beneficiaryImage!,
        beneficiaryId: params.beneficiaryId!,
        otpCode: params.otpCode!,
        isFriend: params.isFriend!,
        fromAccount: params.fromAccount ?? "",
        memo: params.memo!,
        nickName: params.nickName!,
        detCustomerType: params.detCustomerType!,
        type: params.type!,
        recipientName: params.recipientName,
        recipientAddress: params.recipientAddress);
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
  final String? fromAccount;
  final String? toAccount;
  final String? nickName;
  final String? detCustomerType;
  final String? type;
  final num? limit;
  final String? recipientName;
  final String? recipientAddress;

  TransferUseCaseParams(
      {this.beneficiaryId,
      this.otpCode,
      this.transferType,
      this.beneficiaryImage,
      this.isFriend,
      this.toAmount,
      this.localEq,
      this.memo,
      this.fromAccount,
      this.limit,
      this.type,
      this.detCustomerType,
      this.nickName,
      this.toAccount,
      this.recipientName = '',
      this.recipientAddress = ''});

  @override
  Either<AppError, bool> verify() {
    if (memo == null || memo == "") {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_PURPOSE_DETAIL, cause: Exception()));
    }
    if (limit == null) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.NETWORK, cause: Exception()));
    } else if (limit! < toAmount!) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.LIMIT_EXCEEDED, cause: Exception()));
    }
    return Right(true);
  }
}
