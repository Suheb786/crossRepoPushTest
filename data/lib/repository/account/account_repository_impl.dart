import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/account/account_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/check_videocall_status_response.dart';
import 'package:domain/repository/account/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final AccountRemoteDS _accountRemoteDS;

  AccountRepositoryImpl(this._accountRemoteDS);

  @override
  Future<Either<NetworkError, CheckVideoCallResponse>> checkVideoCallStatus(
      {required bool getToken}) async {
    final result = await safeApiCall(
      _accountRemoteDS.checkVideoCallStatus(getToken: getToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}
