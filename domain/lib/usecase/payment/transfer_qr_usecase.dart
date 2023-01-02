import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
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
        toAmount: params.toAmount, toAccount: params.toAccount, requestId: params.requestId);
  }
}

class TransferQRUseCaseParams extends Params {
  final String toAmount;
  final String toAccount;
  final String requestId;

  TransferQRUseCaseParams({required this.toAmount, required this.requestId, required this.toAccount});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
