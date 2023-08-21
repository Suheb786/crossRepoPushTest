import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EVoucherDetailsPageUseCase
    extends BaseUseCase<NetworkError, EVoucherDetailsPageUseCaseParams, VoucherDetail> {
  EVoucherRepository _eVoucherRepository;

  EVoucherDetailsPageUseCase(this._eVoucherRepository);

  @override
  Future<Either<NetworkError, VoucherDetail>> execute({required EVoucherDetailsPageUseCaseParams params}) {
    return _eVoucherRepository.getVoucherDetails(params.orderIdentifier);
  }
}

class EVoucherDetailsPageUseCaseParams extends Params {
  // vouchersByCategory
  final String orderIdentifier;

  EVoucherDetailsPageUseCaseParams({required this.orderIdentifier});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
