import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/qr/qr_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GenerateQRUseCase extends BaseUseCase<NetworkError, GenerateQRUseCaseParams, QrResponse> {
  final PaymentRepository _repository;

  GenerateQRUseCase(this._repository);

  @override
  Future<Either<NetworkError, QrResponse>> execute({required GenerateQRUseCaseParams params}) {
    return _repository.generateQR(amount: params.amount);
  }
}

class GenerateQRUseCaseParams extends Params {
  final String amount;

  GenerateQRUseCaseParams({required this.amount});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
