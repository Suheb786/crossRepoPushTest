import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/kyc/kyc_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/repository/kyc/kyc_repository.dart';

class KYCRepositoryImpl extends KYCRepository {
  final KYCRemoteDS _kycRemoteDS;

  KYCRepositoryImpl(this._kycRemoteDS);

  @override
  Future<Either<NetworkError, CheckKycResponse>> checkKYCStatus() async {
    final result = await safeApiCall(
      _kycRemoteDS.checkKYCStatus(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}
