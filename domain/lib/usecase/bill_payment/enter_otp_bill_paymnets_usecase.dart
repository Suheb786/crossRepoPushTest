import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EnterOtpBillPaymentsUseCase extends BaseUseCase<NetworkError, EnterOtpBillPaymentsUseCaseParams, bool> {
  final BillPaymentRepository billPaymentRepository;

  EnterOtpBillPaymentsUseCase(this.billPaymentRepository);

  @override
  Future<Either<NetworkError, bool>> execute({
    required EnterOtpBillPaymentsUseCaseParams params,
  }) {
    return billPaymentRepository.validateBillerOtp(params: params);
  }
}

class EnterOtpBillPaymentsUseCaseParams extends Params {
  final String? billerType;
  final String? amount;
  final String? currencyCode;
  final String? accountNo;
  final bool? isNewBiller;

  EnterOtpBillPaymentsUseCaseParams(
      {this.billerType, this.amount, this.currencyCode, this.accountNo, this.isNewBiller});

  @override
  Either<AppError, bool> verify() {
    // if (otpCode!.length < 6) {
    //   return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_OTP, cause: Exception()));
    // }
    return Right(true);
  }
}
