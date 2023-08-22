import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EVoucherRegionByCategoriesUseCase extends BaseUseCase<NetworkError,
    EVoucherRegionByCategoriesUseCaseParams, List<VoucherRegionByCategories>> {
  EVoucherRepository _eVoucherRepository;

  EVoucherRegionByCategoriesUseCase(this._eVoucherRepository);

  @override
  Future<Either<NetworkError, List<VoucherRegionByCategories>>> execute(
      {required EVoucherRegionByCategoriesUseCaseParams params}) {
    return _eVoucherRepository.getRegionsByCategories(params.category);
  }
}

class EVoucherRegionByCategoriesUseCaseParams extends Params {
  String category;

  EVoucherRegionByCategoriesUseCaseParams({
    required this.category,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
