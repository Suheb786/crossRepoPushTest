import 'package:dartz/dartz.dart';
import 'package:domain/model/cliq/rejection_reason_inward_request/rejection_reason_inward.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';

import '../../error/network_error.dart';
import '../../model/e_voucher/voucher_categories.dart';

abstract class EVoucherRepository {
  Future<Either<NetworkError, List<VoucherCategories>>> getVoucherCategories();

  Future<Either<NetworkError, List<VoucherItem>>> getVoucherItemsByCategory(String category);

  Future<Either<NetworkError, bool>> getMyVouchers(String pageNo, String fromDate, String toDate);

  Future<Either<NetworkError, bool>> getVoucherDetails(String orderIdentifier);

  Future<Either<NetworkError, List<VoucherItem>>> getVoucherItemsByFilter(
      String category, String region, String minValue, String maxValue);

  Future<Either<NetworkError, List<VoucherItem>>> getVoucherItemsBySearch(String searchText);
}
