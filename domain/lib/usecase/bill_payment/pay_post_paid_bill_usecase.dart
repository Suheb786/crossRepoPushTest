import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PayPostPaidBillUseCase extends BaseUseCase<NetworkError,
    PayPostPaidBillUseCaseParams, PayPostPaidBill> {
  final BillPaymentRepository _repository;

  PayPostPaidBillUseCase(this._repository);

  @override
  Future<Either<NetworkError, PayPostPaidBill>> execute(
      {required PayPostPaidBillUseCaseParams params}) {
    return _repository.payPostPaidBill(params: params);
  }
}

class PayPostPaidBillUseCaseParams extends Params {
  dynamic billerList;
  String? accountNo;
  String? totalAmount;
  String? currencyCode;
  bool? isNewBiller;
  String? otpCode;
  String? nickName;
  String? CardId;
  bool? isCreditCardPayment = false;

  PayPostPaidBillUseCaseParams({
    this.billerList,
    this.accountNo,
    this.totalAmount,
    this.currencyCode,
    this.isNewBiller,
    this.otpCode,
    this.nickName,
    this.CardId,
    this.isCreditCardPayment,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
