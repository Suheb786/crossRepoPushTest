import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../error/base_error.dart';

class EVoucherByCategoryPageUseCase
    extends BaseUseCase<BaseError, EVoucherByCategoryPageUseCaseParams, List<VoucherItem>> {
  EVoucherRepository _eVoucherRepository;

  EVoucherByCategoryPageUseCase(this._eVoucherRepository);

  @override
  Future<Either<BaseError, List<VoucherItem>>> execute(
      {required EVoucherByCategoryPageUseCaseParams params}) {
    return _eVoucherRepository.getVoucherItemsByCategory(params.category);
  }
}

class EVoucherByCategoryPageUseCaseParams extends Params {
  // vouchersByCategory
  final String category;

  EVoucherByCategoryPageUseCaseParams({required this.category});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
