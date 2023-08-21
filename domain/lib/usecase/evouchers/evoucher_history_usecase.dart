import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/e_voucher/voucher_by_date.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EVoucherHistoryUseCase
    extends BaseUseCase<NetworkError, EVoucherHistoryUseCaseParams, List<VouchersByDate>> {
  EVoucherRepository _eVoucherRepository;

  EVoucherHistoryUseCase(this._eVoucherRepository);

  @override
  Future<Either<NetworkError, List<VouchersByDate>>> execute({required EVoucherHistoryUseCaseParams params}) {
    return _eVoucherRepository.getMyVouchers(
        pageNo: params.pageNo,
        rangeOfMonths: params.rangeOfMonths,
        searchPhrase: params.searchPhrase,
        totalRecord: params.totalRecord);
  }
}

class EVoucherHistoryUseCaseParams extends Params {
  int pageNo;
  String searchPhrase;
  int rangeOfMonths;
  int totalRecord;

  EVoucherHistoryUseCaseParams(
      {required this.pageNo,
      required this.rangeOfMonths,
      required this.searchPhrase,
      required this.totalRecord});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
