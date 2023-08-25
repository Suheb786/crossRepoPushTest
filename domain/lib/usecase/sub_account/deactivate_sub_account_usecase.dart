import 'package:dartz/dartz.dart';
import 'package:domain/repository/sub_account/sub_account_repository.dart';
import 'package:domain/usecase/base/params.dart';

import '../../error/app_error.dart';
import '../../error/network_error.dart';
import '../base/base_usecase.dart';

class CloseSubAccountUseCase extends BaseUseCase<NetworkError, CloseSubAccountUseCaseParams, bool> {
  final SubAccountRepository _subAccountRepo;
  CloseSubAccountUseCase(this._subAccountRepo);

  @override
  Future<Either<NetworkError, bool>> execute({required CloseSubAccountUseCaseParams params}) {
    return _subAccountRepo.deActivateSubAccount(params: params);
  }
}

class CloseSubAccountUseCaseParams extends Params {
  final String accountNo;
  final String iban;
  final bool getToken;

  CloseSubAccountUseCaseParams({
    required this.accountNo,
    required this.getToken,
    required this.iban,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
