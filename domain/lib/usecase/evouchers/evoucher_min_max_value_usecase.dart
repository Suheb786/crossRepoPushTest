import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/usecase/evouchers/voucher_min_max_value.dart';

class EVoucherMinMaxValueUseCase
    extends BaseUseCase<BaseError, EVoucherMinMaxValueUseCaseParams, VoucherMinMaxValue> {
  EVoucherRepository _eVoucherRepository;

  EVoucherMinMaxValueUseCase(this._eVoucherRepository);

  @override
  Future<Either<BaseError, VoucherMinMaxValue>> execute({required EVoucherMinMaxValueUseCaseParams params}) {
    return _eVoucherRepository.getMinMaxRange(category: params.category, region: params.region);
  }
}

class EVoucherMinMaxValueUseCaseParams extends Params {
  String category;
  String region;

  EVoucherMinMaxValueUseCaseParams({
    required this.category,
    required this.region,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
