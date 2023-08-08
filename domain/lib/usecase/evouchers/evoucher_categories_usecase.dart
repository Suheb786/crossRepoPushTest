import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EVoucherCategoriesUseCase
    extends BaseUseCase<BaseError, EVoucherCategoriesUseCaseParams, List<VoucherCategories>> {
  EVoucherRepository _eVoucherRepository;

  EVoucherCategoriesUseCase(this._eVoucherRepository);

  @override
  Future<Either<BaseError, List<VoucherCategories>>> execute(
      {required EVoucherCategoriesUseCaseParams params}) {
    return _eVoucherRepository.getVoucherCategories();
  }
}

class EVoucherCategoriesUseCaseParams extends Params {
  EVoucherCategoriesUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
