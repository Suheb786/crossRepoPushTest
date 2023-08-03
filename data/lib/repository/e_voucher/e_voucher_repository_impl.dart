import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/e_voucher/e_voucher_data_source.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/e_voucher/e_voucher_otp.dart';
import 'package:domain/model/e_voucher/get_settlement_amount.dart';
import 'package:domain/model/e_voucher/get_voucher_details.dart';
import 'package:domain/model/e_voucher/place_order.dart';
import 'package:domain/model/e_voucher/voucher_by_date.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/evouchers/e_voucher_otp_usecase.dart';
import 'package:domain/usecase/evouchers/get_settlement_ammount_usecase.dart';
import 'package:domain/usecase/evouchers/get_voucher_details_usecase.dart';
import 'package:domain/usecase/evouchers/place_order_usecase.dart';
import 'package:domain/usecase/evouchers/voucher_min_max_value.dart';

class EVoucherRepositoryImpl extends EVoucherRepository {
  final EVoucherRemoteDS _eVoucherRemoteDS;

  EVoucherRepositoryImpl(this._eVoucherRemoteDS);

  @override
  Future<Either<NetworkError, List<VouchersByDate>>> getMyVouchers(
      {required int pageNo,
      required int rangeOfMonths,
      required String searchPhrase,
      required int totalRecord}) async {
    final result = await safeApiCall(_eVoucherRemoteDS.getMyVouchers(
        pageNo: pageNo, rangeOfMonths: rangeOfMonths, searchPhrase: searchPhrase, totalRecord: totalRecord));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, List<VoucherCategories>>> getVoucherCategories() async {
    final result = await safeApiCall(_eVoucherRemoteDS.getVoucherCategories());
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, VoucherDetail>> getVoucherDetails(String orderIdentifier) async {
    final result = await safeApiCall(_eVoucherRemoteDS.getVoucherDetails(orderIdentifier));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, List<VoucherItem>>> getVoucherItemsByCategory(String category) async {
    final result = await safeApiCall(_eVoucherRemoteDS.getVoucherItemsByCategory(category));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, List<VoucherItem>>> getVoucherItemsByFilter(
      {required String category,
      required String region,
      required num minValue,
      required num maxValue,
      required String searchText}) async {
    final result = await safeApiCall(_eVoucherRemoteDS.getVoucherItemsByFilter(
      category: category,
      region: region,
      searchText: searchText,
      minValue: minValue,
      maxValue: maxValue,
    ));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, List<VoucherItem>>> getVoucherItemsBySearch(String searchText) async {
    final result = await safeApiCall(_eVoucherRemoteDS.getVoucherItemsBySearch(searchText));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, List<VoucherRegionByCategories>>> getRegionsByCategories(
      String category) async {
    final result = await safeApiCall(_eVoucherRemoteDS.getRegionsByCategories(category: category));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, VoucherMinMaxValue>> getMinMaxRange(
      {required String category, required String region}) async {
    final result = await safeApiCall(_eVoucherRemoteDS.getMinMaxRange(category: category, region: region));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, PlaceOrder>> placeOrder({required PlaceOrderUseCaseParams params}) async {
    final result = await safeApiCall(_eVoucherRemoteDS.placeOrder(params: params));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetSettlementAmount>> getSettlementAmount(
      {required GetSettlementAmountUseCaseParams params}) async {
    final result = await safeApiCall(_eVoucherRemoteDS.getSettlementAmount(params: params));
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, EVoucherOTP>> eVoucherOtp({required EVoucherUsecaseOTPParams params}) async {
    final result = await safeApiCall(_eVoucherRemoteDS.eVoucherOtp(params: params));
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, GetVoucherDetails>> getVoucherDetailsApi(
      {required GetVoucherDetailsUseCaseParams params}) async {
    final result = await safeApiCall(_eVoucherRemoteDS.getVoucherDetailsApi(params: params));
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }
}
