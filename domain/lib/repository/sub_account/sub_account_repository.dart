import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/sub_account/update_nick_name_sub_account_usecase.dart';

import '../../usecase/sub_account/add_account_usecase.dart';
import '../../usecase/sub_account/deactivate_sub_account_usecase.dart';

abstract class SubAccountRepository {
  Future<Either<NetworkError, bool>> deActivateSubAccount({
    required CloseSubAccountUseCaseParams params,
  });
  Future<Either<NetworkError, bool>> updateNickNameSubAccount({
    required UpdateNickNameSubAccountUseCaseParams params,
  });
  Future<Either<NetworkError, bool>> accountToAccountTransfer({
    required AccountToAccountTransferUseCaseParams params,
  });
}
