import 'package:dartz/dartz.dart';
import 'package:data/db/exception/app_local_exception.dart';
import 'package:data/source/dynamic_link/dynamic_link_datasource.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/dynamic_link/dynamic_link_repository.dart';
import 'package:flutter/material.dart';

class DynamicLinkRepositoryImpl extends DynamicLinkRepository {
  final DynamicLinkDataSource _dynamicLinkDataSource;

  DynamicLinkRepositoryImpl(this._dynamicLinkDataSource);

  @override
  Future<Either<BaseError, String>> createDynamicLink(
      {required String accountTitle,
      required String accountNo,
      required String requestAmt,
      required String dateTime}) async {
    final result = await _dynamicLinkDataSource.createDynamicLink(
        accountTitle: accountTitle, accountNo: accountNo, requestAmt: requestAmt, dateTime: dateTime);
    if (result.isNotEmpty) {
      return Right(result);
    } else {
      throw Exception();
    }
  }

  @override
  Future<Either<BaseError, Uri>> initDynamicLinks() async {
    final result = await _dynamicLinkDataSource.initDynamicLinks();
    debugPrint('--Result---->$result');
    debugPrint('--Result data---->${result.queryParameters}');
    debugPrint('--Result empty path---->${result.hasEmptyPath}');

    if (result.queryParameters.isNotEmpty) {
      return Right(result);
    } else {
      throw AppLocalException(
        appLocalExceptionType: AppLocalExceptionType.NO_DATA_FOUND,
      );
    }
  }
}
