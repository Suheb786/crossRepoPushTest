import 'package:dartz/dartz.dart';
import 'package:domain/repository/sub_account/sub_account_repository.dart';
import 'package:domain/usecase/base/params.dart';

import '../../error/app_error.dart';
import '../../error/network_error.dart';
import '../base/base_usecase.dart';

class UpdateNickNameSubAccountUseCase
    extends BaseUseCase<NetworkError, UpdateNickNameSubAccountUseCaseParams, bool> {
  final SubAccountRepository _subAccountRepository;
  UpdateNickNameSubAccountUseCase(this._subAccountRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required UpdateNickNameSubAccountUseCaseParams params}) {
    return _subAccountRepository.updateNickNameSubAccount(params: params);
  }
}

class UpdateNickNameSubAccountUseCaseParams extends Params {
  final String NickName;
  final String SubAccountNo;
  final bool GetToken;

  UpdateNickNameSubAccountUseCaseParams({
    required this.NickName,
    required this.SubAccountNo,
    required this.GetToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
