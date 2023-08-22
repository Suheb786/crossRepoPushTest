import 'package:dartz/dartz.dart';
import 'package:domain/repository/sub_account/sub_account_repository.dart';
import 'package:domain/usecase/base/params.dart';

import '../../error/app_error.dart';
import '../../error/network_error.dart';
import '../base/base_usecase.dart';

class DeactivateSubAccountUseCase extends BaseUseCase<NetworkError, DeactivateSubAccountUseCaseParams, bool> {
  final SubAccountRepository _subAccountRepo;
  DeactivateSubAccountUseCase(this._subAccountRepo);

  @override
  Future<Either<NetworkError, bool>> execute({required DeactivateSubAccountUseCaseParams params}) {
    return _subAccountRepo.deActivateSubAccount(params: params);
  }
}

class DeactivateSubAccountUseCaseParams extends Params {
  final String subAccountNo;
  final bool getToken;

  DeactivateSubAccountUseCaseParams({
    required this.subAccountNo,
    required this.getToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
