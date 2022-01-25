import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/video_kyc_status.dart';
import 'package:domain/repository/account/account_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCallStatusUseCase extends BaseUseCase<NetworkError,
    GetCallStatusUseCaseParams, VideoKycStatus> {
  final AccountRepository _accountRepository;

  GetCallStatusUseCase(this._accountRepository);

  @override
  Future<Either<NetworkError, VideoKycStatus>> execute(
      {required GetCallStatusUseCaseParams params}) {
    return _accountRepository.getCallStatus(params.session);
  }
}

class GetCallStatusUseCaseParams extends Params {
  final String session;

  GetCallStatusUseCaseParams({required this.session});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
