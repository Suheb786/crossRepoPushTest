import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/sub_account/sub_account_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/sub_account/sub_account_repository.dart';
import 'package:domain/usecase/sub_account/add_account_usecase.dart';
import 'package:domain/usecase/sub_account/deactivate_sub_account_usecase.dart';
import 'package:domain/usecase/sub_account/update_nick_name_sub_account_usecase.dart';

class SubAccountRepositoryImpl extends SubAccountRepository {
  final SubAccountDataSource _subAccountDataSource;

  SubAccountRepositoryImpl(this._subAccountDataSource);
  @override
  Future<Either<NetworkError, bool>> deActivateSubAccount(
      {required DeactivateSubAccountUseCaseParams params}) async {
    final result = await safeApiCall(_subAccountDataSource.deActivateSubAccount(params: params));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> updateNickNameSubAccount(
      {required UpdateNickNameSubAccountUseCaseParams params}) async {
    final result = await safeApiCall(_subAccountDataSource.updateNickNameSubAccount(params: params));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> addSubAccount(
      {required AddSubAccountSubAccountUseCaseParams params}) async {
    final result = await safeApiCall(_subAccountDataSource.addSubAccount(params: params));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }
}
