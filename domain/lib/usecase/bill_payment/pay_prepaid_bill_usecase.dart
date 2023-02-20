import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PayPrePaidUseCase extends BaseUseCase<NetworkError, PayPrePaidUseCaseParams, PayPrePaid> {
  final BillPaymentRepository _repository;

  PayPrePaidUseCase(this._repository);

  @override
  Future<Either<NetworkError, PayPrePaid>> execute({required PayPrePaidUseCaseParams params}) {
    return _repository.payPrepaidBill(params: params);
  }
}

class PayPrePaidUseCaseParams extends Params {
  final String? billerName;
  final String? billerCode;
  final String? billingNumber;
  final String? serviceType;
  final String? amount;
  final String? fees;
  final String? currencyCode;
  final String? accountNo;
  final String? otpCode;
  final String? validationCode;
  final String? nickName;
  final bool? isNewBiller;
  final String? prepaidCategoryCode;
  final String? CardId;
  final String? prepaidCategoryType;
  final bool? billingNumberRequired;
  final bool? isCreditCardPayment;

  PayPrePaidUseCaseParams(
      {this.billerName,
      this.billerCode,
      this.billingNumber,
      this.serviceType,
      this.amount,
      this.fees,
      this.currencyCode,
      this.CardId,
      this.nickName,
      this.accountNo,
      this.otpCode,
      this.validationCode,
      this.isNewBiller,
      this.prepaidCategoryCode,
      this.prepaidCategoryType,
      this.billingNumberRequired,
      this.isCreditCardPayment});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
