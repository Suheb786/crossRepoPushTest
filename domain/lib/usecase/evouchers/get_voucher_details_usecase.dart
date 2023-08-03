// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/e_voucher/get_voucher_details.dart';

import '../../error/base_error.dart';
import '../../repository/e_voucher/e_voucher_repository.dart';
import '../base/base_usecase.dart';
import '../base/params.dart';

class GetVoucherDetailUseCase
    extends BaseUseCase<BaseError, GetVoucherDetailsUseCaseParams, GetVoucherDetails> {
  final EVoucherRepository _eVoucherRepository;

  GetVoucherDetailUseCase(this._eVoucherRepository);

  @override
  Future<Either<BaseError, GetVoucherDetails>> execute({required GetVoucherDetailsUseCaseParams params}) {
    return _eVoucherRepository.getVoucherDetailsApi(params: params);
  }
}

class GetVoucherDetailsUseCaseParams extends Params {
  final String? OrderIdentifier;

  GetVoucherDetailsUseCaseParams({
    required this.OrderIdentifier,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
