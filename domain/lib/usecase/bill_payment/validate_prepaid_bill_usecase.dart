import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ValidatePrePaidUseCase
    extends BaseUseCase<NetworkError, ValidatePrePaidUseCaseParams, ValidatePrePaidBill> {
  final BillPaymentRepository _repository;

  ValidatePrePaidUseCase(this._repository);

  @override
  Future<Either<NetworkError, ValidatePrePaidBill>> execute({required ValidatePrePaidUseCaseParams params}) {
    return _repository.validatePrePaidBill(params: params);
  }
}

class ValidatePrePaidUseCaseParams extends Params {
  final String? billerCode;
  final String? amount;
  final String? serviceType;
  final String? billingNumber;
  final String? prepaidCategoryCode;
  final String? prepaidCategoryType;
  final bool? billingNumberRequired;
  final String fromAccount;

  ValidatePrePaidUseCaseParams(
      {this.billerCode,
      this.amount = '',
      this.serviceType,
      this.billingNumber,
      this.prepaidCategoryCode,
      this.prepaidCategoryType,
      this.billingNumberRequired,
      required this.fromAccount});

  @override
  Either<AppError, bool> verify() {
    if (prepaidCategoryCode != null &&
        prepaidCategoryCode!.isEmpty &&
        prepaidCategoryType != null &&
        prepaidCategoryType!.isEmpty) {
      if (amount!.isEmpty || amount == "0.000") {
        return Left(
            AppError(cause: Exception(), error: ErrorInfo(message: ''), type: ErrorType.ENTER_AMOUNT));
      }
    }
    return Right(true);
  }
}
