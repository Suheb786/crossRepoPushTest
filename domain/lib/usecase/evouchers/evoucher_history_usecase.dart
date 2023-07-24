import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/e_voucher/voucher_by_date.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EVoucherHistoryUseCase extends BaseUseCase<BaseError,
    EVoucherHistoryUseCaseParams, List<VouchersByDate>> {
  EVoucherRepository _eVoucherRepository;

  EVoucherHistoryUseCase(this._eVoucherRepository);

  @override
  Future<Either<BaseError, List<VouchersByDate>>> execute(
      {required EVoucherHistoryUseCaseParams params}) {
    return _eVoucherRepository.getMyVouchers(
        params.pageNo, params.rangeOfMonths);
  }
}

class EVoucherHistoryUseCaseParams extends Params {
  String pageNo;
  int rangeOfMonths;

  EVoucherHistoryUseCaseParams(
      {required this.pageNo, required this.rangeOfMonths});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
