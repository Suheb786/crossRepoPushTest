import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/model/card/card_statement_response.dart';
import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:domain/model/card/get_credit_card_relationship/credit_card_relationship_respponse.dart';
import 'package:domain/model/card/get_debit_years_response.dart';
import 'package:domain/model/card/get_loan_values/get_loan_values_response.dart';
import 'package:domain/model/card/supplementary_credit_card/supplementary_credit_card_application_response.dart';
import 'package:domain/model/card/supplementary_credit_card/supplementary_credit_card_response.dart';
import 'package:domain/model/credit_card/get_credit_card_limit_response.dart';
import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
import 'package:domain/model/debit_card/debit_card_limit_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/usecase/card_delivery/report_lost_stolen_cc_usecase.dart';
import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_new_mobile_number_usecase.dart';
import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_otp_usecase.dart';
import 'package:domain/usecase/update_settlement/update_settlement_usecase.dart';

abstract class CardRepository {
  Future<Either<NetworkError, CardIssuanceDetails>> getCardIssuanceDetails();

  Future<Either<NetworkError, bool>> setCardPin(String currentPin, String cardNUmber);

  Future<Either<NetworkError, GetTransactionsResponse>> getDebitCardTransactions(
      {num? noOfDays, String? accountNo});

  Future<Either<NetworkError, GetTransactionsResponse>> getCreditCardTransactions(
      {required String cardId, num? noOfDays, required String secureCode, required bool isIssuedFromCMS});

  Future<Either<NetworkError, CardStatementResponse>> getDebitCardStatement(
      String monthYear, String? accountNo);

  Future<Either<NetworkError, CardStatementResponse>> getCreditCardStatement(
      String monthYear, String? cardId, String? secureCode, bool? issuedFromCms);

  Future<Either<NetworkError, bool>> requestCreditCard({required String cardId});

  Future<Either<NetworkError, GetDebitYearsResponse>> getCreditYears();

  Future<Either<NetworkError, GetDebitYearsResponse>> getDebitYears();

  Future<Either<NetworkError, bool>> freezeCreditCard(
      {String cardId, String secureCode, bool? isIssuedFromCMS});

  Future<Either<NetworkError, bool>> unFreezeCreditCard(
      {String cardId, String secureCode, bool? isIssuedFromCMS});

  Future<Either<NetworkError, bool>> cancelCreditCard({String reason});

  Future<Either<NetworkError, bool>> creditCardPinUnblock();

  Future<Either<NetworkError, bool>> freezeDebitCard({String? status, String? tokenizedPan});

  Future<Either<NetworkError, bool>> unFreezeDebitCard({String? status, String? tokenizedPan});

  Future<Either<NetworkError, bool>> cancelDebitCard(
      {String reason, String status, String? tokenizedPan, String? cancellationReason});

  Future<Either<NetworkError, bool>> changeDebitCardPin(
      {required String pin, required String otp, required String tokenizedPan, required String cardNumber});

  Future<Either<NetworkError, bool>> unblockDebitCardPin({String status, required String pin});

  Future<Either<NetworkError, bool>> updateDebitCardLimits(
      {num atmWithdrawal,
      num merchantsPayments,
      num onlinePurchase,
      num contactLessPayments,
      bool isAtmWithdrawal,
      bool isMerchantsPayments,
      bool isOnlinePurchase,
      bool isContactLessPayments,
      String? tokenizedPan,
      bool? updateEcom});

  Future<Either<NetworkError, bool>> updateCreditCardLimits(
      {num atmWithdrawal,
      String? secureCode,
      bool isAtmWithdrawal,
      bool isContactLessPayments,
      bool isMerchantsPayments,
      bool isOnlinePurchase,
      num merchantsPayments,
      num onlinePurchase,
      num contactlessPaymentLimit});

  Future<Either<NetworkError, DebitCardLimitResponse>> getDebitCardLimit({required String? tokenizedPan});

  Future<Either<NetworkError, GetCreditCardLimitResponse>> getCreditCardLimit({required String? secureCode});

  Future<Either<NetworkError, GetCardApplicationResponse>> getCardApplication();

  Future<Either<NetworkError, GetLoanValuesResponse>> getLoanValues({String accountId});

  Future<Either<NetworkError, bool>> processLoanRequest({String cardId, num loanValueId});

  Future<Either<NetworkError, bool>> linkCardStep({required String cardId, required String accountNumber});

  Future<Either<NetworkError, bool>> changePinVerify();

  Future<Either<NetworkError, CardIssuanceDetails>> applyDebitSupplementaryCard(
      {required ScannedDocumentInformation scannedDocumentInformation,
      required String relation,
      required String nickName});

  Future<Either<NetworkError, SupplementaryCreditCardApplicationResponse>>
      getSupplementaryCreditCardApplication({required String primaryCard});

  Future<Either<NetworkError, SupplementaryCreditCardResponse>> supplementaryCreditCardRequest(
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

  Future<Either<NetworkError, bool>> supplementaryCreditCardStepTwo(
      {required String primaryCardId, required String secondaryCardId});

  Future<Either<NetworkError, bool>> supplementaryCreditCardStepThree(
      {required String primaryCardId, required String secondaryCardId, required String accountNumber});

  Future<Either<NetworkError, CreditCardRelationshipResponse>> getCreditCardRelationShipList(
      {required String cardId});

  Future<Either<NetworkError, bool>> callStatusUpdate({String? cardId, String? status});

  Future<Either<NetworkError, bool>> dcChangeLinkedMobileNumberVerify(
      {required DcEnterNewMobileNumberUseCaseParams params});

  Future<Either<NetworkError, bool>> dcChangeLinkedMobileNumber({required DcEnterOtpUseCaseParams params});

  Future<Either<NetworkError, bool>> ccChangeLinkedMobileNumberVerify(
      {required DcEnterNewMobileNumberUseCaseParams params});

  Future<Either<NetworkError, bool>> ccChangeLinkedMobileNumber({required DcEnterOtpUseCaseParams params});

  Future<Either<NetworkError, bool>> updateSettlement({required UpdateSettlementUseCaseParams params});

  Future<Either<NetworkError, bool>> reportLostStolenCC({required ReportLostStolenCCUseCaseParams params});

  Future<Either<NetworkError, CardIssuanceDetails>> removeOrReApplySupplementaryDebitCardWithResponse(
      {required String status, required String tokenizedPan, required bool reApply});

  Future<Either<NetworkError, bool>> removeOrReApplySupplementaryDebitCard(
      {required String status, required String tokenizedPan, required bool reApply});

  Future<Either<NetworkError, bool>> getCardInProcess(
      {String minimumSettlement, String nickName, num loanValueId, num creditLimit});

  Future<Either<NetworkError, bool>> requestPhysicalDebitCard({required String tokenizedPan});

  Future<Either<NetworkError, bool>> changeCreditCardPinVerify({required String cardCode});

  Future<Either<NetworkError, bool>> changeCreditCardPin({
    required String cardCode,
    required String pin,
    required String cardNumber,
    required String otp,
  });

  Future<Either<NetworkError, bool>> unblockCreditCardPin({required String cardCode});
}
