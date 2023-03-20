import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/unlink_cliq_id/unlink_cliq_id_otp.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UnlinkAccountFromCliqOtpUseCase
    extends BaseUseCase<NetworkError, UnlinkAccountFromCliqOtpParams, UnlinkCliqIdOtp> {
  final CliqRepository _cliqRepository;

  UnlinkAccountFromCliqOtpUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, UnlinkCliqIdOtp>> execute({required UnlinkAccountFromCliqOtpParams params}) {
    return _cliqRepository.unLinkAccountFromCliqOtp(
        aliasId: params.aliasId, accountId: params.accountId, getToken: params.getToken);
  }
}

class UnlinkAccountFromCliqOtpParams extends Params {
  final String aliasId;
  final String accountId;

  final bool getToken;

  UnlinkAccountFromCliqOtpParams({required this.aliasId, required this.accountId, required this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
