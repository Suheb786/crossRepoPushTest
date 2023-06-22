import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../error/base_error.dart';

class EVoucherLandingPageUseCase extends BaseUseCase<BaseError, EVoucherLandingPageUseCaseParams, dynamic> {
  EVoucherRepository _eVoucherRepository;

  EVoucherLandingPageUseCase(this._eVoucherRepository);

  @override
  Future<Either<BaseError, dynamic>> execute({required EVoucherLandingPageUseCaseParams params}) {
    switch (params.eVoucherLandingPageDataEnum) {
      case EVoucherLandingPageDataEnum.voucherCategories:
        return _eVoucherRepository.getVoucherCategories();
      case EVoucherLandingPageDataEnum.myVouchers:
        return _eVoucherRepository.getMyVouchers(params.pageNo!, params.fromDate!, params.toDate!);
      case EVoucherLandingPageDataEnum.voucherDetails:
        return _eVoucherRepository.getVoucherDetails(params.orderIdentifier!);
      case EVoucherLandingPageDataEnum.voucherByFilter:
        return _eVoucherRepository.getVoucherItemsByFilter(
            params.category!, params.region!, params.minValue!, params.maxValue!);
      case EVoucherLandingPageDataEnum.voucherBySearch:
        return _eVoucherRepository.getVoucherItemsBySearch(params.searchText!);
    }
  }
}

class EVoucherLandingPageUseCaseParams extends Params {
  final EVoucherLandingPageDataEnum eVoucherLandingPageDataEnum;

  // my vouchers
  final String? pageNo;
  final String? fromDate;
  final String? toDate;

  // voucherDetails
  final String? orderIdentifier;

  // vouchersByCategory
  final String? category;

  // voucherByFilter
  final String? region;
  final String? minValue;
  final String? maxValue;

  // voucherBySearch
  String? searchText;

  EVoucherLandingPageUseCaseParams(
      {required this.eVoucherLandingPageDataEnum,
      this.pageNo,
      this.fromDate,
      this.toDate,
      this.orderIdentifier,
      this.category,
      this.region,
      this.minValue,
      this.maxValue,
      this.searchText});

  @override
  Either<AppError, bool> verify() {
    switch (eVoucherLandingPageDataEnum) {
      case EVoucherLandingPageDataEnum.voucherCategories:
        return Right(true);

      case EVoucherLandingPageDataEnum.myVouchers:
        if (pageNo == null) {
          return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.UI, cause: Exception()));
        }
        if (fromDate == null) {
          return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.UI, cause: Exception()));
        }
        if (toDate == null) {
          return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.UI, cause: Exception()));
        }
        return Right(true);

      case EVoucherLandingPageDataEnum.voucherDetails:
        if (orderIdentifier == null) {
          return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.UI, cause: Exception()));
        }
        return Right(true);

      case EVoucherLandingPageDataEnum.voucherByFilter:
        if (region == null) {
          return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.UI, cause: Exception()));
        }
        if (minValue == null) {
          return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.UI, cause: Exception()));
        }
        if (maxValue == null) {
          return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.UI, cause: Exception()));
        }
        return Right(true);

      case EVoucherLandingPageDataEnum.voucherBySearch:
        if (searchText == null) {
          return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.UI, cause: Exception()));
        }
        return Right(true);
    }
  }
}

enum EVoucherLandingPageDataEnum {
  voucherCategories,
  myVouchers,
  voucherDetails,
  // vouchersByCategory,
  voucherByFilter,
  voucherBySearch,
}
