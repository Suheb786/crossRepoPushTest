import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/check_other_nationality_status_response.dart';
import 'package:domain/repository/account/account_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckOtherNationalityStatusUseCase extends BaseUseCase<NetworkError,
    CheckOtherNationalityStatusUseCaseParams, CheckOtherNationalityResponse> {
  final AccountRepository _accountRepository;

  CheckOtherNationalityStatusUseCase(this._accountRepository);

  @override
  Future<Either<NetworkError, CheckOtherNationalityResponse>> execute(
      {required CheckOtherNationalityStatusUseCaseParams params}) {
    return _accountRepository.checkOtherNationalityStatus(getToken: true);
  }
}

class CheckOtherNationalityStatusUseCaseParams extends Params {
  CheckOtherNationalityStatusUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
