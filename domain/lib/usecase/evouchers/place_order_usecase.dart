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
  final String Denomination;
  final String exchangeRate;
  final String reconcilationCurrency;
  final String Discount;
  final String VoucherName;
  final String VoucherCategory;
  final String AccountNo;
  final bool GetToken;
  PlaceOrderUseCaseParams({
    required this.Denomination,
    required this.exchangeRate,
    required this.reconcilationCurrency,
    required this.Discount,
    required this.VoucherName,
    required this.VoucherCategory,
    required this.AccountNo,
    required this.GetToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
