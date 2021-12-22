import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/model/card/card_statement_response.dart';
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
      int noOfDays);
}
