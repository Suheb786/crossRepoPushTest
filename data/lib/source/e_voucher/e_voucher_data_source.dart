import 'package:data/entity/remote/e_voucher/voucher_category/voucher_categories_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_detail/voucher_details_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_history/voucher_history_list_response_entity.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_filter_response_entity.dart';
import 'package:domain/usecase/evouchers/e_voucher_otp_usecase.dart';
import 'package:domain/usecase/evouchers/place_order_usecase.dart';
import 'package:retrofit/dio.dart';
import 'package:domain/usecase/evouchers/get_settlement_ammount_usecase.dart';

abstract class EVoucherRemoteDS {
  Future<HttpResponse<VoucherCategoriesResponseEntity>> getVoucherCategories();

  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsByCategory(String category);

  Future<HttpResponse<VoucherHistoryListResponseEntity>> getMyVouchers(String pageNo, int transactionPeriod);

  Future<HttpResponse<VoucherDetailsResponseEntity>> getVoucherDetails(String orderIdentifier);

  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsByFilter(
      {required String category,
      required String region,
      required String searchText,
      required num minValue,
      required num maxValue});

  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsBySearch(String searchText);

  Future<HttpResponse<bool>> placeOrder({
    required PlaceOrderUseCaseParams params,
  });

  Future<HttpResponse<bool>> getSettlementAmount({
    required GetSettlementAmountUseCaseParams params,
  });

  Future<HttpResponse<bool>> eVoucherOtp({
    required EVoucherUsecaseParams params,
  });
}
