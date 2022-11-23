import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class TransferApiNoOtpUseCase
    extends BaseUseCase<NetworkError, TransferApiNoOtpUseCaseParams, TransferSuccessResponse> {
  final PaymentRepository _repository;

  TransferApiNoOtpUseCase(this._repository);

  @override
  Future<Either<NetworkError, TransferSuccessResponse>> execute(
      {required TransferApiNoOtpUseCaseParams params}) {
    return _repository.transferAPINoOtp(
        transferType: params.transferType!,
        toAmount: params.toAmount!,
        toAccount: params.toAccount!,
        localEq: params.localEq!,
        beneficiaryImage: params.beneficiaryImage!,
        beneficiaryId: params.beneficiaryId!,
        isFriend: params.isFriend!,
        memo: params.memo!,
        nickName: params.nickName!,
        detCustomerType: params.detCustomerType!,
        type: params.type!);
  }
}

class TransferApiNoOtpUseCaseParams extends Params {
  final String? beneficiaryId;
  final String? transferType;
  final String? beneficiaryImage;
  final bool? isFriend;
  final num? toAmount;
  final num? localEq;
  final String? memo;
  final String? toAccount;
  final String? nickName;
  final String? detCustomerType;
  final String? type;
  final num? limit;

  TransferApiNoOtpUseCaseParams(
      {this.beneficiaryId,
      this.transferType,
      this.beneficiaryImage,
      this.isFriend,
      this.toAmount,
      this.localEq,
      this.memo,
      this.limit,
      this.type,
      this.detCustomerType,
      this.nickName,
      this.toAccount});

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
