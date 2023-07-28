// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';

import '../../error/app_error.dart';
import '../../error/network_error.dart';
import '../base/base_usecase.dart';
import '../base/params.dart';

class PlaceOrderUseCase extends BaseUseCase<NetworkError, PlaceOrderUseCaseParams, bool> {
  final EVoucherRepository _eVoucherRepository;
  PlaceOrderUseCase(this._eVoucherRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required PlaceOrderUseCaseParams params}) {
    return _eVoucherRepository.placeOrder(params: params);
  }
}

class PlaceOrderUseCaseParams extends Params {
  final String sourceAccount;
  final String sourceCurrency;
  final String cardItemId;
  final double exchangeRate;
  final String voucherCurrency;
  final String reconciliationCurrency;
  final String equivalentAmount;
  final int denomination;
  final String discount;
  final String categories;
  final String voucherName;
  final String productId;
  final String productName;
  final String otpCode;
  final bool getToken;

  PlaceOrderUseCaseParams({
    required this.sourceAccount,
    required this.sourceCurrency,
    required this.cardItemId,
    required this.exchangeRate,
    required this.voucherCurrency,
    required this.reconciliationCurrency,
    required this.equivalentAmount,
    required this.denomination,
    required this.discount,
    required this.categories,
    required this.voucherName,
    required this.productId,
    required this.productName,
    required this.otpCode,
    required this.getToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
