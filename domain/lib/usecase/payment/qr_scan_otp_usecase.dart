import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class QRScanOTPUseCase extends BaseUseCase<BaseError, QRScanOTPUseCaseParams, bool> {
  final PaymentRepository _repository;

  QRScanOTPUseCase(this._repository);

  @override
  Future<Either<BaseError, bool>> execute({required QRScanOTPUseCaseParams params}) async {
    return _repository.qrScanOTP();
  }
}

class QRScanOTPUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
