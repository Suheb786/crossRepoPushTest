import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/card/card_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/model/card/card_statement_response.dart';
import 'package:domain/model/card/get_debit_years_response.dart';
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
      String monthYear) async {
    final result = await safeApiCall(
      _remoteDs.getCreditCardStatement(monthYear: monthYear),
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
      {required double cardLimit}) async {
    final result = await safeApiCall(
      _remoteDs.requestCreditCard(cardLimit: cardLimit),
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
  Future<Either<NetworkError, bool>> freezeCreditCard() async {
    final result = await safeApiCall(
      _remoteDs.freezeCreditCard(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> unFreezeCreditCard() async {
    final result = await safeApiCall(
      _remoteDs.unFreezeCreditCard(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> cancelDebitCard({String? reason}) async {
    final result = await safeApiCall(
      _remoteDs.cancelDebitCard(reason: reason),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> freezeDebitCard() async {
    final result = await safeApiCall(
      _remoteDs.freezeDebitCard(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> unFreezeDebitCard() async {
    final result = await safeApiCall(
      _remoteDs.unFreezeDebitCard(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> changeDebitCardPin(
      {required String pin}) async {
    final result = await safeApiCall(
      _remoteDs.changeDebitCardPin(pin: pin),
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
      _remoteDs.unblockDebitCardPin(pin: pin),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> updateDebitCardLimits(
      {num? atmWithdrawal,
      num? merchantsPayments,
      num? onlinePurchase,
      num? contactLessPayments,
      bool? isAtmWithdrawal,
      bool? isMerchantsPayments,
      bool? isOnlinePurchase,
      bool? isContactLessPayments}) async {
    final result = await safeApiCall(
      _remoteDs.updateDebitCardLimits(
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
}
