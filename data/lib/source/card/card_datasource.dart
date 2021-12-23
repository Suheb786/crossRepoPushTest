import 'package:data/entity/remote/card/card_issuance_response_entity.dart';
import 'package:data/entity/remote/card/card_statement_response_entity.dart';
import 'package:data/entity/remote/card/card_transaction_response_entity.dart';
import 'package:data/entity/remote/card/debit_years_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class CardRemoteDs {
  Future<HttpResponse<CardIssuanceResponseEntity>> getCardIssuanceDetails();

  Future<HttpResponse<ResponseEntity>> setCardPin(String pin);

  Future<HttpResponse<ResponseEntity>> confirmCardDelivery();

  Future<HttpResponse<ResponseEntity>> confirmCreditCardDelivery();

  Future<HttpResponse<CardTransactionResponseEntity>>
      getDebitCardTransactions();

  Future<HttpResponse<CardTransactionResponseEntity>>
      getCreditCardTransactions();

  Future<HttpResponse<ResponseEntity>> requestCreditCard(
      {required double cardLimit});

  Future<HttpResponse<DebitYearsResponseEntity>> getCreditYears();

  Future<HttpResponse<DebitYearsResponseEntity>> getDebitYears();

  Future<HttpResponse<ResponseEntity>> getCreditCardStatement();

  Future<HttpResponse<CardStatementResponseEntity>> getDebitCardStatement(
      {int noOfDays});
}
