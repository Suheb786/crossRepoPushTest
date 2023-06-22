import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/dynamic_link/dynamic_link_datasource.dart';
import 'package:data/source/e_voucher/e_voucher_data_source.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/rejection_reason_inward_request/rejection_reason_inward.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:flutter/material.dart';

class EVoucherRepositoryImpl extends EVoucherRepository {
  final EVoucherRemoteDS _eVoucherRemoteDS;

  EVoucherRepositoryImpl(this._eVoucherRemoteDS);

  @override
  Future<Either<NetworkError, bool>> getMyVouchers(String pageNo, String fromDate, String toDate) async {
    final result = await safeApiCall(_eVoucherRemoteDS.getMyVouchers(pageNo, fromDate, toDate));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
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
  Future<Either<NetworkError, bool>> getVoucherDetails(String orderIdentifier) async {
    final result = await safeApiCall(_eVoucherRemoteDS.getVoucherDetails(orderIdentifier));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
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
      String category, String region, String minValue, String maxValue) async {
    final result =
        await safeApiCall(_eVoucherRemoteDS.getVoucherItemsByFilter(category, region, minValue, maxValue));
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
}
