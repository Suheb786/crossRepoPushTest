import 'package:dartz/dartz.dart';
import 'package:domain/repository/sub_account/sub_account_repository.dart';

import '../../error/app_error.dart';
import '../../error/network_error.dart';
import '../../model/sub_account/account_to_account_transfer_response.dart';
import '../base/base_usecase.dart';
import '../base/params.dart';

class AccountToAccountTransferUseCase extends BaseUseCase<NetworkError, AccountToAccountTransferUseCaseParams,
    AccountToAccountTransferResponse> {
  final SubAccountRepository _subAccountRepository;
  AccountToAccountTransferUseCase(this._subAccountRepository);

  @override
  Future<Either<NetworkError, AccountToAccountTransferResponse>> execute(
      {required AccountToAccountTransferUseCaseParams params}) {
    return _subAccountRepository.accountToAccountTransfer(params: params);
  }
}

class AccountToAccountTransferUseCaseParams extends Params {
  final String? FromAccount;
  final String? ToAccount;
  final bool? GetToken;
  final double? TransferAmount;

  AccountToAccountTransferUseCaseParams({
    this.FromAccount,
    this.ToAccount,
    this.TransferAmount,
    this.GetToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
