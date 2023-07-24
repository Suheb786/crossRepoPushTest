import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EVoucherItemFilterUseCase extends BaseUseCase<BaseError,
    EVoucherItemFilterUseCaseParams, List<VoucherItem>> {
  EVoucherRepository _eVoucherRepository;

  EVoucherItemFilterUseCase(this._eVoucherRepository);

  @override
  Future<Either<BaseError, List<VoucherItem>>> execute(
      {required EVoucherItemFilterUseCaseParams params}) {
    return _eVoucherRepository.getVoucherItemsByFilter(
        category: params.category,
        region: params.region,
        minValue: params.minValue,
        maxValue: params.maxValue,
        searchText: params.searchText);
  }
}

class EVoucherItemFilterUseCaseParams extends Params {
  String category;
  String region;
  num minValue;
  num maxValue;
  String searchText;

  EVoucherItemFilterUseCaseParams(
      {required this.category,
      required this.region,
      required this.maxValue,
      required this.minValue,
      required this.searchText});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
