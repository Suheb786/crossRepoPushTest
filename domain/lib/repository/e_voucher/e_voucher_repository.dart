import 'package:dartz/dartz.dart';

import '../../error/network_error.dart';

abstract class EVoucherRepository {
  Future<Either<NetworkError, bool>> getVoucherCategories();

  Future<Either<NetworkError, bool>> getVoucherItemsByCategory(String category);

  Future<Either<NetworkError, bool>> getMyVouchers(String pageNo, String fromDate, String toDate);

  Future<Either<NetworkError, bool>> getVoucherDetails(String orderIdentifier);

  Future<Either<NetworkError, bool>> getVoucherItemsByFilter(
      String category, String region, String minValue, String maxValue);

  Future<Either<NetworkError, bool>> getVoucherItemsBySearch(String searchText);
}
