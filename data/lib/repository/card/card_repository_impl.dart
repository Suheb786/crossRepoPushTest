import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/card/card_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/model/card/card_statement_response.dart';
import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
import 'package:domain/repository/card/card_repository.dart';

class CardRepositoryImpl extends CardRepository {
  final CardRemoteDs _remoteDs;

  CardRepositoryImpl(this._remoteDs);

  @override
  Future<Either<NetworkError, CardIssuanceDetails>>
  getCardIssuanceDetails() async {
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

  @override
  Future<Either<NetworkError, bool>> confirmCardDelivery() async {
    final result = await safeApiCall(
      _remoteDs.confirmCardDelivery(),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, GetTransactionsResponse>>
      getDebitCardTransactions() async {
    final result = await safeApiCall(
      _remoteDs.getDebitCardTransactions(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetTransactionsResponse>>
      getCreditCardTransactions() async {
    final result = await safeApiCall(
      _remoteDs.getCreditCardTransactions(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> confirmCreditCardDelivery() async {
    final result = await safeApiCall(
      _remoteDs.confirmCreditCardDelivery(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, CardStatementResponse>> getDebitCardStatement(
       int noOfDays) async {
    final result = await safeApiCall(
      _remoteDs.getDebitCardStatement(noOfDays: noOfDays),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}
