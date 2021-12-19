import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/doc_status_response.dart';
import 'package:domain/repository/account/account_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckDocStatusUseCase extends BaseUseCase<NetworkError,
    CheckDocStatusUseCaseParams,
    DocStatusResponse> {
  final AccountRepository _accountRepository;

  CheckDocStatusUseCase(this._accountRepository);

  @override
  Future<Either<NetworkError, DocStatusResponse>> execute(
      {required CheckDocStatusUseCaseParams params}) {
    return _accountRepository.docStatus();
  }
}

class CheckDocStatusUseCaseParams extends Params {
  CheckDocStatusUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
