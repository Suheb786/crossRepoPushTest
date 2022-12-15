import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/qr/verify_qr_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class VerifyQRUseCase extends BaseUseCase<NetworkError, VerifyQRUseCaseParams, VerifyQrResponse> {
  final PaymentRepository _repository;

  VerifyQRUseCase(this._repository);

  @override
  Future<Either<NetworkError, VerifyQrResponse>> execute({required VerifyQRUseCaseParams params}) {
    return _repository.verifyQR(requestId: params.requestId, source: params.source);
  }
}

class VerifyQRUseCaseParams extends Params {
  final String requestId;
  final String source;

  VerifyQRUseCaseParams({required this.requestId, required this.source});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
