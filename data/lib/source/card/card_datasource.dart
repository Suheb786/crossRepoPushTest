import 'package:data/entity/remote/card/card_issuance_response_entity.dart';
import 'package:data/entity/remote/card/card_statement_response_entity.dart';
import 'package:data/entity/remote/card/card_transaction_response_entity.dart';
import 'package:data/entity/remote/card/credit_card_relationship/credit_card_relationship_response_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_application_response_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_request_response_entity.dart';
import 'package:data/entity/remote/card/debit_years_response_entity.dart';
import 'package:data/entity/remote/card/get_card_application/get_card_application_response_entity.dart';
import 'package:data/entity/remote/card/get_loan_values/get_loan_values_response_entity.dart';
import 'package:data/entity/remote/card/process_loan_request/process_loan_response_entity.dart';
import 'package:data/entity/remote/debit_card/debit_card_limit_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:retrofit/retrofit.dart';

abstract class CardRemoteDs {
  Future<HttpResponse<CardIssuanceResponseEntity>> getCardIssuanceDetails();

  Future<HttpResponse<ResponseEntity>> setCardPin(
      String pin, String cardNumber);

  Future<HttpResponse<ResponseEntity>> confirmCardDelivery();

  Future<HttpResponse<ResponseEntity>> confirmCreditCardDelivery(
      {String? cardId, String? cardDigit});

  Future<HttpResponse<CardTransactionResponseEntity>>
      getDebitCardTransactions();

  Future<HttpResponse<CardTransactionResponseEntity>> getCreditCardTransactions(
      {required String cardId});

  Future<HttpResponse<ResponseEntity>> requestCreditCard(
      {required String cardId});

  Future<HttpResponse<DebitYearsResponseEntity>> getCreditYears();

  Future<HttpResponse<DebitYearsResponseEntity>> getDebitYears();

  Future<HttpResponse<DebitCardLimitResponseEntity>> getDebitCardLimit(
      {required String? tokenizedPan});

  Future<HttpResponse<CardStatementResponseEntity>> getCreditCardStatement(
      {String? monthYear, String? cardId});

  Future<HttpResponse<CardStatementResponseEntity>> getDebitCardStatement(
      {String monthYear});

  Future<HttpResponse<ResponseEntity>> freezeCreditCard({String cardId});

  Future<HttpResponse<ResponseEntity>> unFreezeCreditCard({String cardId});

  Future<HttpResponse<ResponseEntity>> cancelCreditCard({String? reason});

  Future<HttpResponse<ResponseEntity>> creditCardPinUnBlock();

  Future<HttpResponse<ResponseEntity>> cancelDebitCard(
      {String? reason, String? status, String? tokenizedPan});

  Future<HttpResponse<ResponseEntity>> unFreezeDebitCard(
      {String? status, String? tokenizedPan});

  Future<HttpResponse<ResponseEntity>> freezeDebitCard(
      {String? status, String? tokenizedPan});

  Future<HttpResponse<ResponseEntity>> changeDebitCardPin(
      {required String pin,
      required String otp,
      required String tokenizedPan,
      required String cardNumber});

  Future<HttpResponse<ResponseEntity>> unblockDebitCardPin(
      {required String pin, required String status});

  Future<HttpResponse<ResponseEntity>> updateDebitCardLimits(
      {num? atmWithdrawal,
      num? merchantsPayments,
      num? onlinePurchase,
      num? contactLessPayments,
      bool? isAtmWithdrawal,
      bool? isMerchantsPayments,
      bool? isOnlinePurchase,
      String? tokenizedPan,
      bool? isContactLessPayments});

  Future<HttpResponse<ResponseEntity>> updateCreditCardLimits(
      {num? atmWithdrawal,
      num? merchantsPayments,
      num? onlinePurchase,
      num? contactLessPayments,
      bool? isAtmWithdrawal,
      bool? isMerchantsPayments,
      bool? isOnlinePurchase,
      bool? isContactLessPayments});

  Future<HttpResponse<GetCardApplicationResponseEntity>> getCardApplication();

  Future<HttpResponse<GetLoanValuesResponseEntity>> getLoanValues(
      {String? accountId});

  Future<HttpResponse<ProcessLoanResponseEntity>> processLoanRequest(
      {String? minimumSettlement,
      String? nickName,
      num? loanValueId,
      num? creditLimit});

  Future<HttpResponse<ResponseEntity>> linkCardStep(
      {String cardId, String accountNumber});

  Future<HttpResponse<ResponseEntity>> changePinVerify();

  Future<HttpResponse<ResponseEntity>> applyDebitSupplementaryCard(
      {required ScannedDocumentInformation scannedDocumentInformation,
      required String relation,
      required String nickName});

  Future<HttpResponse<SupplementaryCreditCardApplicationResponseEntity>>
      getSupplementaryCreditCardApplication({required String primaryCard});

  Future<HttpResponse<SupplementaryCreditCardRequestResponseEntity>>
      supplementaryCreditCardRequest(
          {required String primaryCardId,
          required String relationship,
          dynamic doi,
          required String type,
          required String fullName,
          required String firstName,
          required String middleName,
          required String familyName,
          required String idNumber,
          required String dob,
          required String doe,
          required String gender,
          required String documentCode,
          required String issuer,
          required String nationality,
          required String documentNumber,
          required String optionalData1,
          required String optionalData2,
          required String mrtDraw,
          required String frontCardImage,
          required String backCardImage,
          required String nickName,
          required bool sameLimit,
          required num limit});

  Future<HttpResponse<ResponseEntity>> supplementaryCreditCardStepTwo(
      {required String primaryCardId, required String secondaryCardId});

  Future<HttpResponse<ResponseEntity>> supplementaryCreditCardStepThree(
      {required String primaryCardId,
      required String secondaryCardId,
      required String accountNumber});

  Future<HttpResponse<CreditCardRelationshipResponseEntity>>
      getCreditCardRelationShipList({required String cardId});
}
