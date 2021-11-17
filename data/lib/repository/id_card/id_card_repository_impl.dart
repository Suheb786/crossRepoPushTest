import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/id_card/id_card_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/id_card/id_card_repository.dart';

class IdCardRepositoryImpl extends IdCardRepository {
  final IdCardRemoteDS _idCardRemoteDS;

  IdCardRepositoryImpl(this._idCardRemoteDS);

  @override
  Future<Either<NetworkError, String>> getAhwalDetails(
      {required String idNo}) async {
    final result = await safeApiCall(
      _idCardRemoteDS.getAhwalDetails(idNo: idNo),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
