import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/change_default_account/change_default_account_otp.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ChangeDefaultAccountOtpUseCase
    extends BaseUseCase<NetworkError, ChangeDefaultAccountOtpUseCaseParams, ChangeDefaultAccountOtp> {
  final CliqRepository _cliqRepository;

  ChangeDefaultAccountOtpUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, ChangeDefaultAccountOtp>> execute(
      {required ChangeDefaultAccountOtpUseCaseParams params}) {
    return _cliqRepository.changeDefaultAccountOtp(acc: params.acc, aliasId: params.aliasId);
  }
}

class ChangeDefaultAccountOtpUseCaseParams extends Params {
  final String acc;
  final String aliasId;

  ChangeDefaultAccountOtpUseCaseParams({required this.acc, required this.aliasId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
