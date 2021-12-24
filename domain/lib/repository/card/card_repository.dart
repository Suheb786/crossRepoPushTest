import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/model/card/card_statement_response.dart';
import 'package:domain/model/card/get_debit_years_response.dart';
import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';

abstract class CardRepository {
  Future<Either<NetworkError, CardIssuanceDetails>> getCardIssuanceDetails();

  Future<Either<NetworkError, bool>> setCardPin(String currentPin);

  Future<Either<NetworkError, bool>> confirmCardDelivery();

  Future<Either<NetworkError, GetTransactionsResponse>>
      getDebitCardTransactions();

  Future<Either<NetworkError, GetTransactionsResponse>>
      getCreditCardTransactions();

  Future<Either<NetworkError, bool>> confirmCreditCardDelivery();

  Future<Either<NetworkError, CardStatementResponse>> getDebitCardStatement(
      String monthYear);

  Future<Either<NetworkError, CardStatementResponse>> getCreditCardStatement(
      String monthYear);

  Future<Either<NetworkError, bool>> requestCreditCard(
      {required double cardLimit});

  Future<Either<NetworkError, GetDebitYearsResponse>> getCreditYears();

  Future<Either<NetworkError, GetDebitYearsResponse>> getDebitYears();
}
