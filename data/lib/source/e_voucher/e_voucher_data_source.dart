import 'package:retrofit/dio.dart';

import '../../entity/remote/user/response_entity.dart';

abstract class EVoucherRemoteDS {
  Future<HttpResponse<ResponseEntity>> getVoucherCategories();

  Future<HttpResponse<ResponseEntity>> getVoucherItemsByCategory(String category);

  Future<HttpResponse<ResponseEntity>> getMyVouchers(String pageNo, String fromDate, String toDate);

  Future<HttpResponse<ResponseEntity>> getVoucherDetails(String orderIdentifier);

  Future<HttpResponse<ResponseEntity>> getVoucherItemsByFilter(
      String category, String region, String minValue, String maxValue);

  Future<HttpResponse<ResponseEntity>> getVoucherItemsBySearch(String searchText);
}
