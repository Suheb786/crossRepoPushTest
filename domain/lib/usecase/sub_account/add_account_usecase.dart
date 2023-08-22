import 'package:dartz/dartz.dart';
import 'package:domain/repository/sub_account/sub_account_repository.dart';

import '../../error/app_error.dart';
import '../../error/network_error.dart';
import '../base/base_usecase.dart';
import '../base/params.dart';

class AddSubAccountUseCase extends BaseUseCase<NetworkError, AddSubAccountSubAccountUseCaseParams, bool> {
  final SubAccountRepository _subAccountRepository;
  AddSubAccountUseCase(this._subAccountRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required AddSubAccountSubAccountUseCaseParams params}) {
    return _subAccountRepository.addSubAccount(params: params);
  }
}

class AddSubAccountSubAccountUseCaseParams extends Params {
  final String? NickName;
  final String? SubAccountNo;
  final bool? GetToken;

  AddSubAccountSubAccountUseCaseParams({
    required this.NickName,
    required this.SubAccountNo,
    required this.GetToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
