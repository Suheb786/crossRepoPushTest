import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/payment/payment_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/model/purpose/purpose_response.dart';
import 'package:domain/model/qr/qr_response.dart';
import 'package:domain/model/qr/qr_transfer_response.dart';
import 'package:domain/model/qr/verify_qr_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentRemoteDs paymentRemoteDs;

  PaymentRepositoryImpl(this.paymentRemoteDs);

  @override
  Future<Either<NetworkError, GetAccountByAliasContentResponse>> getAccountByAlias(
      String value, String currency) async {
    final result = await safeApiCall(
      paymentRemoteDs.getAccountByAlias(value, currency),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, CheckSendMoneyResponse>> checkSendMoney(String toAccount, num toAmount) async {
    final result = await safeApiCall(
      paymentRemoteDs.checkSendMoney(toAccount: toAccount, toAmount: toAmount),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, TransferSuccessResponse>> transfer(
      {String? beneficiaryId,
        String? otpCode,
        String? transferType,
        String? beneficiaryImage,
        bool? isFriend,
        num? toAmount,
        num? localEq,
        String? memo,
        String? toAccount,
        String? nickName,
        String? detCustomerType,
        String? type,
        String? recipientName,
        String? recipientAddress}) async {
    final result = await safeApiCall(
      paymentRemoteDs.transfer(
          beneficiaryId: beneficiaryId!,
          otpCode: otpCode,
          transferType: transferType!,
          beneficiaryImage: beneficiaryImage!,
          isFriend: isFriend!,
          toAmount: toAmount!,
          localEq: localEq!,
          memo: memo!,
          toAccount: toAccount!,
          nickName: nickName!,
          detCustomerType: detCustomerType!,
          type: type!,
          recipientName: recipientName,
          recipientAddress: recipientAddress),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, RequestToPayContentResponse>> requestToPay(
      String ctgyPurp,
      num amount,
      String dbtrBic,
      String dbtrAcct,
      String dbtrName,
      String memo,
      bool? isFriend,
      String? image,
      String? nickName,
      String? detCustomerType,
      String? type,
      String? alias,
      String? dbtrSurname,
      String? addressCity,
      String? addressCountry) async {
    final result = await safeApiCall(
      paymentRemoteDs.requestToPay(ctgyPurp, amount, dbtrBic, dbtrAcct, dbtrName, memo, isFriend, image,
          nickName, detCustomerType, type, alias, dbtrSurname, addressCity, addressCountry),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> transferVerify({required String amount}) async {
    final result = await safeApiCall(
      paymentRemoteDs.transferVerify(amount: amount),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, PurposeResponse>> getPurpose(
      String toAccount, String transferType, String detCustomerType, String type) async {
    final result = await safeApiCall(
      paymentRemoteDs.getPurpose(toAccount, transferType, detCustomerType, type),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, PaymentActivityResponse>> getPaymentActivity({int? filterDays}) async {
    final result = await safeApiCall(
      paymentRemoteDs.getPaymentActivity(filterDays: filterDays),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> payBackCreditCard({String? secureCode, String? payBackAmount}) async {
    final result = await safeApiCall(
      paymentRemoteDs.payBackCreditCard(secureCode: secureCode, payBackAmount: payBackAmount),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, TransferSuccessResponse>> transferAPINoOtp(
      {String? beneficiaryId,
      String? transferType,
      String? beneficiaryImage,
      bool? isFriend,
      num? toAmount,
      num? localEq,
      String? memo,
      String? toAccount,
      String? nickName,
      String? detCustomerType,
      String? type}) async {
    final result = await safeApiCall(
      paymentRemoteDs.transferAPINoOtp(
          beneficiaryId: beneficiaryId!,
          transferType: transferType!,
          beneficiaryImage: beneficiaryImage!,
          isFriend: isFriend!,
          toAmount: toAmount!,
          localEq: localEq!,
          memo: memo!,
          toAccount: toAccount!,
          nickName: nickName!,
          detCustomerType: detCustomerType!,
          type: type!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, QrResponse>> generateQR({required String amount}) async {
    final result = await safeApiCall(
      paymentRemoteDs.generateQR(amount: amount),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, QRTransferResponse>> transferQR(
      {required String requestId, required String toAmount, required String toAccount}) async {
    final result = await safeApiCall(
      paymentRemoteDs.transferQR(requestId: requestId, toAmount: toAmount, toAccount: toAccount),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, VerifyQrResponse>> verifyQR(
      {required String requestId, required String source}) async {
    final result = await safeApiCall(
      paymentRemoteDs.verifyQR(requestId: requestId, source: source),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}
