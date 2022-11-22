import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/check_existing_call_status.dart';
import 'package:domain/repository/account/account_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckExistingCallUseCase
    extends BaseUseCase<NetworkError, CheckExistingCallUseCaseParams, CheckExistingCallStatus> {
  final AccountRepository _accountRepository;

  CheckExistingCallUseCase(this._accountRepository);

  @override
  Future<Either<NetworkError, CheckExistingCallStatus>> execute(
      {required CheckExistingCallUseCaseParams params}) {
    return _accountRepository.checkExistingCall();
  }
}

class CheckExistingCallUseCaseParams extends Params {
  CheckExistingCallUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
