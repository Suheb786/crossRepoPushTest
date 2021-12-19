import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/check_videocall_status_response.dart';
import 'package:domain/repository/account/account_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckVideoCallStatusUseCase extends BaseUseCase<NetworkError,
    CheckVideoCallStatusUseCaseParams,
    CheckVideoCallResponse> {
  final AccountRepository _accountRepository;

  CheckVideoCallStatusUseCase(this._accountRepository);

  @override
  Future<Either<NetworkError, CheckVideoCallResponse>> execute(
      {required CheckVideoCallStatusUseCaseParams params}) {
    return _accountRepository.checkVideoCallStatus(getToken: true);
  }
}

class CheckVideoCallStatusUseCaseParams extends Params {
  CheckVideoCallStatusUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
