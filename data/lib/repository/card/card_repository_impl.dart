import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/card/card_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';

class CardRepositoryImpl extends CardRepository {
  final CardRemoteDs _remoteDs;

  CardRepositoryImpl(this._remoteDs);

  @override
  Future<Either<NetworkError, String>> getCardIssuanceDetails() async {
    final result = await safeApiCall(
      _remoteDs.getCardIssuanceDetails(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> setCardPin(String pin) async {
    final result = await safeApiCall(
      _remoteDs.setCardPin(pin),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }
}
