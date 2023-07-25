import 'package:dartz/dartz.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/usecase/evouchers/e_voucher_otp_usecase.dart';
import 'package:domain/usecase/evouchers/get_settlement_ammount_usecase.dart';
import 'package:domain/usecase/evouchers/place_order_usecase.dart';

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

  Future<Either<NetworkError, bool>> placeOrder({
    required PlaceOrderUseCaseParams params,
  });

  Future<Either<NetworkError, bool>> getSettlementAmount({
    required GetSettlementAmountUseCaseParams params,
  });

  Future<Either<NetworkError, bool>> eVoucherOtp({
    required EVoucherUsecaseParams params,
  });
}
