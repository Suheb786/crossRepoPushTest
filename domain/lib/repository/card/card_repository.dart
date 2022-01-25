import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/model/card/card_statement_response.dart';
import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:domain/model/card/get_debit_years_response.dart';
import 'package:domain/model/card/get_loan_values/get_loan_values_response.dart';
import 'package:domain/model/card/process_loan_request/process_loan_request_response.dart';
import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
import 'package:domain/model/debit_card/debit_card_limit_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';

abstract class CardRepository {
  Future<Either<NetworkError, CardIssuanceDetails>> getCardIssuanceDetails();

  Future<Either<NetworkError, bool>> setCardPin(
      String currentPin, String cardNUmber);

  Future<Either<NetworkError, bool>> confirmCardDelivery();

  Future<Either<NetworkError, GetTransactionsResponse>>
      getDebitCardTransactions();

  Future<Either<NetworkError, GetTransactionsResponse>>
      getCreditCardTransactions();

  Future<Either<NetworkError, bool>> confirmCreditCardDelivery(
      {String? cardId, String? cardDigit});

  Future<Either<NetworkError, CardStatementResponse>> getDebitCardStatement(
      String monthYear);

  Future<Either<NetworkError, CardStatementResponse>> getCreditCardStatement(
      String monthYear);

  Future<Either<NetworkError, bool>> requestCreditCard(
      {required String cardId});

  Future<Either<NetworkError, GetDebitYearsResponse>> getCreditYears();

  Future<Either<NetworkError, GetDebitYearsResponse>> getDebitYears();

  Future<Either<NetworkError, bool>> freezeCreditCard({String cardId});

  Future<Either<NetworkError, bool>> unFreezeCreditCard({String cardId});

  Future<Either<NetworkError, bool>> cancelCreditCard({String reason});

  Future<Either<NetworkError, bool>> creditCardPinUnblock();

  Future<Either<NetworkError, bool>> freezeDebitCard(
      {String? status, String? tokenizedPan});

  Future<Either<NetworkError, bool>> unFreezeDebitCard(
      {String? status, String? tokenizedPan});

  Future<Either<NetworkError, bool>> cancelDebitCard(
      {String reason, String status, String? tokenizedPan});

  Future<Either<NetworkError, bool>> changeDebitCardPin(
      {required String pin,
      required String otp,
      required String tokenizedPan,
      required String cardNumber});

  Future<Either<NetworkError, bool>> unblockDebitCardPin(
      {String status, required String pin});

  Future<Either<NetworkError, bool>> updateDebitCardLimits({
    num atmWithdrawal,
    num merchantsPayments,
    num onlinePurchase,
    num contactLessPayments,
    bool isAtmWithdrawal,
    bool isMerchantsPayments,
    bool isOnlinePurchase,
    bool isContactLessPayments,
    String? tokenizedPan,
  });

  Future<Either<NetworkError, bool>> updateCreditCardLimits(
      {num atmWithdrawal,
      num contactLessPayments,
      bool isAtmWithdrawal,
      bool isContactLessPayments,
      bool isMerchantsPayments,
      bool isOnlinePurchase,
      num merchantsPayments,
      num onlinePurchase});

  Future<Either<NetworkError, DebitCardLimitResponse>> getDebitCardLimit();

  Future<Either<NetworkError, GetCardApplicationResponse>> getCardApplication();

  Future<Either<NetworkError, GetLoanValuesResponse>> getLoanValues(
      {String accountId});

  Future<Either<NetworkError, ProcessLoanRequestResponse>> processLoanRequest(
      {String minimumSettlement,
      String nickName,
      num loanValueId,
      num creditLimit});

  Future<Either<NetworkError, bool>> linkCardStep(
      {required String cardId, required String accountNumber});

  Future<Either<NetworkError, bool>> changePinVerify();

  Future<Either<NetworkError, bool>> applyDebitSupplementaryCard(
      {required ScannedDocumentInformation scannedDocumentInformation,
      required String relation,
      required String nickName});
}
