// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetSettlementAmountUseCase extends BaseUseCase<BaseError, GetSettlementAmountUseCaseParams, bool> {
  final EVoucherRepository _eVoucherRepository;

  GetSettlementAmountUseCase(this._eVoucherRepository);

  @override
  Future<Either<BaseError, bool>> execute({required GetSettlementAmountUseCaseParams params}) {
    return _eVoucherRepository.getSettlementAmount(params: params);
  }
}

class GetSettlementAmountUseCaseParams extends Params {
  final String? Denomination;
  final String? exchangeRate;
  final String? reconcilationCurrency;
  final String? Discount;
  final String? VoucherName;
  final String? VoucherCategory;
  final String? AccountNo;
  final bool? GetToken;
  GetSettlementAmountUseCaseParams({
    this.Denomination,
    this.exchangeRate,
    this.reconcilationCurrency,
    this.Discount,
    this.VoucherName,
    this.VoucherCategory,
    this.AccountNo,
    this.GetToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
