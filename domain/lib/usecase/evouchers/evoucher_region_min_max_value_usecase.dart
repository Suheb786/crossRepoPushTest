import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/e_voucher/voucher_region_min_max_value.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EVoucherRegionMinMaxValueUseCase
    extends BaseUseCase<NetworkError, EVoucherRegionMinMaxValueUseCaseParams, VoucherRegionsAndMinMax> {
  EVoucherRepository _eVoucherRepository;

  EVoucherRegionMinMaxValueUseCase(this._eVoucherRepository);

  @override
  Future<Either<NetworkError, VoucherRegionsAndMinMax>> execute(
      {required EVoucherRegionMinMaxValueUseCaseParams params}) {
    return _eVoucherRepository.regionsAndMinMax();
  }
}

class EVoucherRegionMinMaxValueUseCaseParams extends Params {
  EVoucherRegionMinMaxValueUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
