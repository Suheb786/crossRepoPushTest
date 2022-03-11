import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/card/card_datasource.dart';
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
  Future<Either<NetworkError, bool>> setCardPin(
      String pin, String cardNumber) async {
    final result = await safeApiCall(
      _remoteDs.setCardPin(pin, cardNumber),
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
      getCreditCardTransactions({required String cardId}) async {
    final result = await safeApiCall(
      _remoteDs.getCreditCardTransactions(cardId: cardId),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> confirmCreditCardDelivery(
      {String? cardId, String? cardDigit}) async {
    final result = await safeApiCall(
      _remoteDs.confirmCreditCardDelivery(cardId: cardId, cardDigit: cardDigit),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, CardStatementResponse>> getDebitCardStatement(
      String monthYear) async {
    final result = await safeApiCall(
      _remoteDs.getDebitCardStatement(monthYear: monthYear),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, CardStatementResponse>> getCreditCardStatement(
      String monthYear, String? cardId) async {
    final result = await safeApiCall(
      _remoteDs.getCreditCardStatement(monthYear: monthYear, cardId: cardId),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetDebitYearsResponse>> getCreditYears() async {
    final result = await safeApiCall(
      _remoteDs.getCreditYears(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetDebitYearsResponse>> getDebitYears() async {
    final result = await safeApiCall(
      _remoteDs.getDebitYears(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> requestCreditCard(
      {required String cardId}) async {
    final result = await safeApiCall(
      _remoteDs.requestCreditCard(cardId: cardId),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> cancelCreditCard({String? reason}) async {
    final result = await safeApiCall(
      _remoteDs.cancelCreditCard(reason: reason),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> creditCardPinUnblock() async {
    final result = await safeApiCall(
      _remoteDs.creditCardPinUnBlock(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> freezeCreditCard({String? cardId}) async {
    final result = await safeApiCall(
      _remoteDs.freezeCreditCard(cardId: cardId!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> unFreezeCreditCard(
      {String? cardId}) async {
    final result = await safeApiCall(
      _remoteDs.unFreezeCreditCard(cardId: cardId!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> cancelDebitCard(
      {String? reason, String? status, String? tokenizedPan}) async {
    final result = await safeApiCall(
      _remoteDs.cancelDebitCard(
          reason: reason, status: status, tokenizedPan: tokenizedPan),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> freezeDebitCard(
      {String? status, String? tokenizedPan}) async {
    final result = await safeApiCall(
      _remoteDs.freezeDebitCard(status: status, tokenizedPan: tokenizedPan),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> unFreezeDebitCard(
      {String? status, String? tokenizedPan}) async {
    final result = await safeApiCall(
      _remoteDs.unFreezeDebitCard(status: status, tokenizedPan: tokenizedPan),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> changeDebitCardPin(
      {required String pin,
      required String otp,
      required String cardNumber,
      required String tokenizedPan}) async {
    final result = await safeApiCall(
      _remoteDs.changeDebitCardPin(
          pin: pin,
          tokenizedPan: tokenizedPan,
          otp: otp,
          cardNumber: cardNumber),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> unblockDebitCardPin(
      {String? status, required String pin}) async {
    final result = await safeApiCall(
      _remoteDs.unblockDebitCardPin(pin: pin, status: status!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> updateDebitCardLimits({
    num? atmWithdrawal,
    num? merchantsPayments,
    num? onlinePurchase,
    num? contactLessPayments,
    bool? isAtmWithdrawal,
    bool? isMerchantsPayments,
    bool? isOnlinePurchase,
    bool? isContactLessPayments,
    String? tokenizedPan,
  }) async {
    final result = await safeApiCall(
      _remoteDs.updateDebitCardLimits(
          atmWithdrawal: atmWithdrawal,
          merchantsPayments: merchantsPayments,
          onlinePurchase: onlinePurchase,
          contactLessPayments: contactLessPayments,
          isAtmWithdrawal: isAtmWithdrawal,
          isMerchantsPayments: isMerchantsPayments,
          isOnlinePurchase: isOnlinePurchase,
          isContactLessPayments: isContactLessPayments,
          tokenizedPan: tokenizedPan),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> updateCreditCardLimits(
      {num? atmWithdrawal,
      num? contactLessPayments,
      bool? isAtmWithdrawal,
      bool? isContactLessPayments,
      bool? isMerchantsPayments,
      bool? isOnlinePurchase,
      num? merchantsPayments,
      num? onlinePurchase}) async {
    final result = await safeApiCall(
      _remoteDs.updateCreditCardLimits(
          atmWithdrawal: atmWithdrawal,
          merchantsPayments: merchantsPayments,
          onlinePurchase: onlinePurchase,
          contactLessPayments: contactLessPayments,
          isAtmWithdrawal: isAtmWithdrawal,
          isMerchantsPayments: isMerchantsPayments,
          isOnlinePurchase: isOnlinePurchase,
          isContactLessPayments: isContactLessPayments),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, DebitCardLimitResponse>> getDebitCardLimit(
      {required String? tokenizedPan}) async {
    final result = await safeApiCall(
      _remoteDs.getDebitCardLimit(tokenizedPan: tokenizedPan),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetCardApplicationResponse>>
      getCardApplication() async {
    final result = await safeApiCall(
      _remoteDs.getCardApplication(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetLoanValuesResponse>> getLoanValues(
      {String? accountId}) async {
    final result = await safeApiCall(
      _remoteDs.getLoanValues(accountId: accountId),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, ProcessLoanRequestResponse>> processLoanRequest(
      {String? minimumSettlement,
      String? nickName,
      num? loanValueId,
      num? creditLimit}) async {
    final result = await safeApiCall(_remoteDs.processLoanRequest(
        minimumSettlement: minimumSettlement,
        nickName: nickName,
        loanValueId: loanValueId,
        creditLimit: creditLimit));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> linkCardStep(
      {required String cardId, required String accountNumber}) async {
    final result = await safeApiCall(
      _remoteDs.linkCardStep(cardId: cardId, accountNumber: accountNumber),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> changePinVerify() async {
    final result = await safeApiCall(
      _remoteDs.changePinVerify(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> applyDebitSupplementaryCard(
      {required ScannedDocumentInformation scannedDocumentInformation,
      required String relation,
      required String nickName}) async {
    final result = await safeApiCall(
      _remoteDs.applyDebitSupplementaryCard(
          scannedDocumentInformation: scannedDocumentInformation,
          relation: relation,
          nickName: nickName),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> getSupplementaryCreditCardApplication(
      {required String primaryCard}) async {
    final result = await safeApiCall(
      _remoteDs.getSupplementaryCreditCardApplication(primaryCard: primaryCard),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> supplementaryCreditCardRequest(
      {required String primaryCardId,
      required String relationship,
      doi,
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
      required num limit}) async {
    final result = await safeApiCall(
      _remoteDs.supplementaryCreditCardRequest(
          primaryCardId: primaryCardId,
          relationship: relationship,
          type: type,
          fullName: fullName,
          firstName: firstName,
          middleName: middleName,
          familyName: familyName,
          idNumber: idNumber,
          dob: dob,
          doe: doe,
          gender: gender,
          documentCode: documentCode,
          issuer: issuer,
          nationality: nationality,
          documentNumber: documentNumber,
          optionalData1: optionalData1,
          optionalData2: optionalData2,
          mrtDraw: mrtDraw,
          frontCardImage: frontCardImage,
          backCardImage: backCardImage,
          nickName: nickName,
          sameLimit: sameLimit,
          limit: limit),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> supplementaryCreditCardStepTwo(
      {required String primaryCardId, required String secondaryCardId}) async {
    final result = await safeApiCall(_remoteDs.supplementaryCreditCardStepTwo(
        primaryCardId: primaryCardId, secondaryCardId: secondaryCardId));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> supplementaryCreditCardStepThree(
      {required String primaryCardId,
      required String secondaryCardId,
      required String accountNumber}) async {
    final result = await safeApiCall(_remoteDs.supplementaryCreditCardStepThree(
        primaryCardId: primaryCardId,
        secondaryCardId: secondaryCardId,
        accountNumber: accountNumber));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> getCreditCardRelationShipList(
      {required String cardId}) async {
    final result =
        await safeApiCall(_remoteDs.getCreditCardRelationShipList(cardId: cardId));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }
}
