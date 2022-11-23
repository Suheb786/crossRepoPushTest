import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/repository/account/account_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckGenderStatusUseCase
    extends BaseUseCase<NetworkError, CheckGenderStatusUseCaseParams, AgentGenderStatus> {
  final AccountRepository _accountRepository;

  CheckGenderStatusUseCase(this._accountRepository);

  @override
  Future<Either<NetworkError, AgentGenderStatus>> execute({required CheckGenderStatusUseCaseParams params}) {
    return _accountRepository.checkGenderStatus();
  }
}

class CheckGenderStatusUseCaseParams extends Params {
  CheckGenderStatusUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
