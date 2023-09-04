// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../model/e_voucher/get_settlement_amount.dart';

class GetSettlementAmountUseCase
    extends BaseUseCase<NetworkError, GetSettlementAmountUseCaseParams, GetSettlementAmount> {
  final EVoucherRepository _eVoucherRepository;

  GetSettlementAmountUseCase(this._eVoucherRepository);

  @override
  Future<Either<NetworkError, GetSettlementAmount>> execute(
      {required GetSettlementAmountUseCaseParams params}) {
    return _eVoucherRepository.getSettlementAmount(params: params);
  }
}

class GetSettlementAmountUseCaseParams extends Params {
  final String? Amount;
  final String? FromCurrency;
  final String? ToCurrency;

  final bool? GetToken;

  GetSettlementAmountUseCaseParams({
    required this.Amount,
    required this.FromCurrency,
    required this.ToCurrency,
    required this.GetToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
