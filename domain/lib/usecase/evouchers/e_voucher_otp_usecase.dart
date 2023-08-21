// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/e_voucher/e_voucher_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';

import '../../model/e_voucher/e_voucher_otp.dart';
import '../base/params.dart';

class EVoucherOtpUseCase extends BaseUseCase<NetworkError, EVoucherUsecaseOTPParams, EVoucherOTP> {
  final EVoucherRepository _eVoucherRepository;

  EVoucherOtpUseCase(this._eVoucherRepository);

  @override
  Future<Either<NetworkError, EVoucherOTP>> execute({required EVoucherUsecaseOTPParams params}) {
    return _eVoucherRepository.eVoucherOtp(params: params);
  }
}

class EVoucherUsecaseOTPParams extends Params {
  final String? voucherName;

  EVoucherUsecaseOTPParams({
    required this.voucherName,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
