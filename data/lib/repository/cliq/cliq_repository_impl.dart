import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/cliq/clip_data_source.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';

class CliqRepositoryImpl extends CliqRepository {
  final CliqDataSource _cliqDataSource;

  CliqRepositoryImpl(this._cliqDataSource);

  @override
  Future<Either<NetworkError, bool>> editCliqID(
      {required bool isAlias,
      required String aliasId,
      required String aliasValue,
      required String OtpCode,
      required bool getToken}) async {
    final result = await safeApiCall(
      _cliqDataSource.editCliqID(
          isAlias: isAlias, aliasId: aliasId, aliasValue: aliasValue, OtpCode: OtpCode, getToken: getToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> deleteCliqId({required String aliasId, required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.deleteCliqId(aliasId: aliasId, getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> reActivateCliqId(
      {required String aliasId, required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.reActivateCliqId(aliasId: aliasId, getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> suspendCliqId({required String aliasId, required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.suspendCliqId(aliasId: aliasId, getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }
}
