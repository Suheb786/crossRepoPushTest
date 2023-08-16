import 'package:dartz/dartz.dart';
import 'package:domain/usecase/base/params.dart';

import '../../error/app_error.dart';
import '../../error/network_error.dart';
import '../../repository/account/account_repository.dart';
import '../base/base_usecase.dart';

class SendMobileOTPUsecase extends BaseUseCase<NetworkError, SendMobileOTPUsecaseParams, bool> {
  final AccountRepository _accountRepository;

  SendMobileOTPUsecase(this._accountRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required SendMobileOTPUsecaseParams params}) {
    return _accountRepository.sendMobileOTP(params: params);
  }
}

class SendMobileOTPUsecaseParams extends Params {
  final bool GetToken;
  final String MobileNumber;
  final String MobileCode;

  SendMobileOTPUsecaseParams({
    required this.GetToken,
    required this.MobileNumber,
    required this.MobileCode,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
