import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/payment/payment_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/get_rejection_reason/get_rejection_reason_response.dart';
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
      String fromAccount, String value, String currency, String? beneficiaryId) async {
    final result = await safeApiCall(
      paymentRemoteDs.getAccountByAlias(fromAccount, value, currency, beneficiaryId),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, CheckSendMoneyResponse>> checkSendMoney(
      String? fromAccount, String toAccount, num toAmount, String beneficiaryId) async {
    final result = await safeApiCall(
      paymentRemoteDs.checkSendMoney(
          toAccount: toAccount, toAmount: toAmount, beneficiaryId: beneficiaryId, fromAccount: fromAccount),
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
      String? fromAccount,
      String? detCustomerType,
      String? type,
      String? recipientName,
      String? recipientAddress}) async {
    final result = await safeApiCall(
      paymentRemoteDs.transfer(
          beneficiaryId: beneficiaryId!,
          otpCode: otpCode,
          fromAccount: fromAccount,
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
      String fromAccount,
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
      paymentRemoteDs.requestToPay(fromAccount, ctgyPurp, amount, dbtrBic, dbtrAcct, dbtrName, memo, isFriend,
          image, nickName, detCustomerType, type, alias, dbtrSurname, addressCity, addressCountry),
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
      {required String requestId,
      required String toAmount,
      required String toAccount,
      required String otp}) async {
    final result = await safeApiCall(
      paymentRemoteDs.transferQR(requestId: requestId, toAmount: toAmount, toAccount: toAccount, otp: otp),
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

  @override
  Future<Either<NetworkError, GetRejectionReasonResponseModel>> getReturnRejectionReason(
      {required bool GetToken}) async {
    final result = await safeApiCall(paymentRemoteDs.getReturnRejectionReason(getToken: GetToken));
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, bool>> qrScanOTP() async {
    final result = await safeApiCall(
      paymentRemoteDs.qrScanOTP(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }
}
