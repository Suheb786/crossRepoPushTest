import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/check_agent_status_response.dart';
import 'package:domain/repository/account/account_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckAgentStatusUseCase extends BaseUseCase<NetworkError,
    CheckAgentStatusUseCaseParams, CheckAgentStatusResponse> {
  final AccountRepository _accountRepository;

  CheckAgentStatusUseCase(this._accountRepository);

  @override
  Future<Either<NetworkError, CheckAgentStatusResponse>> execute(
      {required CheckAgentStatusUseCaseParams params}) {
    return _accountRepository.checkAgentStatus();
  }
}

class CheckAgentStatusUseCaseParams extends Params {
  CheckAgentStatusUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
