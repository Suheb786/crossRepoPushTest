import 'package:data/entity/remote/e_voucher/my_voucher/my_voucher_response_entity.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_filter_response_entity.dart';
import 'package:retrofit/dio.dart';

import '../../entity/remote/user/response_entity.dart';

abstract class EVoucherRemoteDS {
  Future<HttpResponse<MyVoucherResponseEntity>> getVoucherCategories();

  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsByCategory(String category);

  Future<HttpResponse<ResponseEntity>> getMyVouchers(String pageNo, String fromDate, String toDate);

  Future<HttpResponse<ResponseEntity>> getVoucherDetails(String orderIdentifier);

  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsByFilter(
      String category, String region, String minValue, String maxValue);

  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsBySearch(String searchText);
}
