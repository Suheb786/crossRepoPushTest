import 'package:dartz/dartz.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:domain/usecase/evouchers/voucher_min_max_value.dart';

import '../../error/network_error.dart';
import '../../model/e_voucher/voucher_by_date.dart';
import '../../model/e_voucher/voucher_categories.dart';

abstract class EVoucherRepository {
  Future<Either<NetworkError, List<VoucherCategories>>> getVoucherCategories();

  Future<Either<NetworkError, List<VoucherItem>>> getVoucherItemsByCategory(String category);

  Future<Either<NetworkError, List<VouchersByDate>>> getMyVouchers(
      {required int pageNo,
      required int rangeOfMonths,
      required String searchPhrase});

  Future<Either<NetworkError, VoucherDetail>> getVoucherDetails(String orderIdentifier);

  Future<Either<NetworkError, List<VoucherItem>>> getVoucherItemsByFilter(
      {required String category,
      required String region,
      required num minValue,
      required num maxValue,
      required String searchText});

  Future<Either<NetworkError, List<VoucherItem>>> getVoucherItemsBySearch(String searchText);

  Future<Either<NetworkError, List<VoucherRegionByCategories>>> getRegionsByCategories(String category);

  Future<Either<NetworkError, VoucherMinMaxValue>> getMinMaxRange({
    required String category,
    required String region,
  });
}
