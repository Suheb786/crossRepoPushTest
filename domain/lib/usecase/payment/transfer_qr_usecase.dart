import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/qr/qr_transfer_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class TransferQRUseCase extends BaseUseCase<NetworkError, TransferQRUseCaseParams, QRTransferResponse> {
  final PaymentRepository _repository;

  TransferQRUseCase(this._repository);

  @override
  Future<Either<NetworkError, QRTransferResponse>> execute({required TransferQRUseCaseParams params}) {
    return _repository.transferQR(
        toAmount: params.toAmount, toAccount: params.toAccount, requestId: params.requestId, otp: params.otp);
  }
}

class TransferQRUseCaseParams extends Params {
  final String toAmount;
  final String toAccount;
  final String requestId;
  final String otp;

  TransferQRUseCaseParams(
      {required this.toAmount, required this.requestId, required this.toAccount, required this.otp});

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_OTP, cause: Exception()));
    }
    return Right(true);
  }
}
