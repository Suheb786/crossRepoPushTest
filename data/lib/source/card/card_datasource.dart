import 'package:data/entity/remote/card/account_card_statement_response_entity.dart';
import 'package:data/entity/remote/card/card_issuance_response_entity.dart';
import 'package:data/entity/remote/card/card_statement_response_entity.dart';
import 'package:data/entity/remote/card/card_transaction_response_entity.dart';
import 'package:data/entity/remote/card/credit_card_relationship/credit_card_relationship_response_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_application_response_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_request_response_entity.dart';
import 'package:data/entity/remote/card/debit_years_response_entity.dart';
import 'package:data/entity/remote/card/get_card_application/get_card_application_response_entity.dart';
import 'package:data/entity/remote/card/get_loan_values/get_loan_values_response_entity.dart';
import 'package:data/entity/remote/credit_card_limit/get_credit_card_limit_response_entity.dart';
import 'package:data/entity/remote/debit_card/debit_card_limit_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/usecase/card_delivery/report_lost_stolen_cc_usecase.dart';
import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_new_mobile_number_usecase.dart';
import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_otp_usecase.dart';
import 'package:domain/usecase/update_settlement/update_settlement_usecase.dart';
import 'package:retrofit/retrofit.dart';

abstract class CardRemoteDs {
  Future<HttpResponse<CardIssuanceResponseEntity>> getCardIssuanceDetails();

  Future<HttpResponse<ResponseEntity>> setCardPin(String pin, String cardNumber);

  Future<HttpResponse<CardTransactionResponseEntity>> getDebitCardTransactions(
      {num? noOfDays, String? accountNo});

  Future<HttpResponse<CardTransactionResponseEntity>> getCreditCardTransactions(
      {required String cardId, num? noOfDays, required String secureCode, required bool isIssuedFromCMS});

  Future<HttpResponse<ResponseEntity>> requestCreditCard({required String cardId});

  Future<HttpResponse<DebitYearsResponseEntity>> getCreditYears();

  Future<HttpResponse<DebitYearsResponseEntity>> getDebitYears();

  Future<HttpResponse<DebitCardLimitResponseEntity>> getDebitCardLimit({required String? tokenizedPan});

  Future<HttpResponse<GetCreditCardLimitResponseEntity>> getCreditCardLimit({required String? secureCode});

  Future<HttpResponse<CardStatementResponseEntity>> getCreditCardStatement(
      {String? monthYear, String? cardId, String? secureCode, bool? issuedFromCms});

  Future<HttpResponse<AccountCardStatementResponseEntity>> getDebitCardStatement(
      {String monthYear, String? accountNo});

  Future<HttpResponse<ResponseEntity>> freezeCreditCard(
      {String cardId, String? secureCode, bool? isIssuedFromCMS});

  Future<HttpResponse<ResponseEntity>> unFreezeCreditCard(
      {String cardId, String? secureCode, bool? isIssuedFromCMS});

  Future<HttpResponse<ResponseEntity>> cancelCreditCard({String? reason});

  Future<HttpResponse<ResponseEntity>> creditCardPinUnBlock();

  Future<HttpResponse<ResponseEntity>> cancelDebitCard(
      {String? reason, String? status, String? tokenizedPan, String? cancellationReason});

  Future<HttpResponse<ResponseEntity>> unFreezeDebitCard({String? status, String? tokenizedPan});

  Future<HttpResponse<ResponseEntity>> freezeDebitCard({String? status, String? tokenizedPan});

  Future<HttpResponse<ResponseEntity>> changeDebitCardPin(
      {required String pin, required String otp, required String tokenizedPan, required String cardNumber});

  Future<HttpResponse<ResponseEntity>> unblockDebitCardPin({required String pin, required String status});

  Future<HttpResponse<ResponseEntity>> updateDebitCardLimits(
      {num? atmWithdrawal,
      num? merchantsPayments,
      num? onlinePurchase,
      num? contactLessPayments,
      bool? isAtmWithdrawal,
      bool? isMerchantsPayments,
      bool? isOnlinePurchase,
      String? tokenizedPan,
      bool? isContactLessPayments,
      bool? updateEcom});

  Future<HttpResponse<ResponseEntity>> updateCreditCardLimits(
      {num? atmWithdrawal,
      num? merchantsPayments,
      num? onlinePurchase,
      num? contactlessPaymentLimit,
      String? secureCode,
      bool? isAtmWithdrawal,
      bool? isMerchantsPayments,
      bool? isOnlinePurchase,
      bool? isContactLessPayments});

  Future<HttpResponse<GetCardApplicationResponseEntity>> getCardApplication();

  Future<HttpResponse<GetLoanValuesResponseEntity>> getLoanValues({String? accountId});

  Future<HttpResponse<ResponseEntity>> processLoanRequest({String? cardId, num? loanValueId});

  Future<HttpResponse<ResponseEntity>> linkCardStep({String cardId, String accountNumber});

  Future<HttpResponse<ResponseEntity>> changePinVerify();

  Future<HttpResponse<CardIssuanceResponseEntity>> applyDebitSupplementaryCard(
      {required ScannedDocumentInformation scannedDocumentInformation,
      required String relation,
      required String nickName});

  Future<HttpResponse<SupplementaryCreditCardApplicationResponseEntity>>
      getSupplementaryCreditCardApplication({required String primaryCard});

  Future<HttpResponse<SupplementaryCreditCardRequestResponseEntity>> supplementaryCreditCardRequest(
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
      {required String primaryCardId, required String secondaryCardId, required String accountNumber});

  Future<HttpResponse<CreditCardRelationshipResponseEntity>> getCreditCardRelationShipList(
      {required String cardId});

  Future<HttpResponse<ResponseEntity>> callStatusUpdate({String? cardId, String? status});

  Future<HttpResponse<ResponseEntity>> dcChangeLinkedMobileNumberVerify(
      {required DcEnterNewMobileNumberUseCaseParams params});

  Future<HttpResponse<ResponseEntity>> dcChangeLinkedMobileNumber({required DcEnterOtpUseCaseParams params});

  Future<HttpResponse<ResponseEntity>> ccChangeLinkedMobileNumberVerify(
      {required DcEnterNewMobileNumberUseCaseParams params});

  Future<HttpResponse<ResponseEntity>> ccChangeLinkedMobileNumber({required DcEnterOtpUseCaseParams params});

  Future<HttpResponse<ResponseEntity>> updateSettlement({required UpdateSettlementUseCaseParams params});

  Future<HttpResponse<ResponseEntity>> reportLostStolenCC({ReportLostStolenCCUseCaseParams params});

  Future<HttpResponse<CardIssuanceResponseEntity>> removeOrReApplySupplementaryDebitCardWithResponse(
      {required String status, required String tokenizedPan, required bool reApply});

  Future<HttpResponse<ResponseEntity>> removeOrReApplySupplementaryDebitCard(
      {required String status, required String tokenizedPan, required bool reApply});

  Future<HttpResponse<ResponseEntity>> getCardInProcess(
      {String? minimumSettlement, String? nickName, num? loanValueId, num? creditLimit});

  Future<HttpResponse<ResponseEntity>> requestPhysicalDebitCard({required String tokenizedPan});

  Future<HttpResponse<ResponseEntity>> changeCreditCardPin(
      {required String cardCode, required String pin, required String cardNumber, required String otp});

  Future<HttpResponse<ResponseEntity>> changeCreditCardPinVerify({required String cardCode});

  Future<HttpResponse<ResponseEntity>> unblockCreditCardPin({required String cardCode});
}
