import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/get_rejection_reason/get_rejection_reason_response.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/model/purpose/purpose_response.dart';
import 'package:domain/model/qr/qr_response.dart';
import 'package:domain/model/qr/qr_transfer_response.dart';
import 'package:domain/model/qr/verify_qr_response.dart';

abstract class PaymentRepository {
  Future<Either<NetworkError, GetAccountByAliasContentResponse>> getAccountByAlias(
      String value, String currency, String? beneficiaryId);

  Future<Either<NetworkError, CheckSendMoneyResponse>> checkSendMoney(
      String toAccount, num toAmount, String beneficiaryId);

  Future<Either<NetworkError, TransferSuccessResponse>> transfer(
      {String beneficiaryId,
      String? otpCode,
      String transferType,
      String beneficiaryImage,
      bool isFriend,
      num toAmount,
      num localEq,
      String memo,
      String toAccount,
      String nickName,
      String? detCustomerType,
      String? type,
      String? recipientName,
      String? recipientAddress});

  Future<Either<NetworkError, bool>> transferVerify({required String amount});

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
      String? addressCountry);

  Future<Either<NetworkError, PurposeResponse>> getPurpose(
      String toAccount, String transferType, String detCustomerType, String type);

  Future<Either<NetworkError, bool>> payBackCreditCard({String? secureCode, String? payBackAmount});

  Future<Either<NetworkError, GetRejectionReasonResponseModel>> getReturnRejectionReason({
    required bool GetToken,
  });

  ///QR
  Future<Either<NetworkError, QrResponse>> generateQR({
    required String amount,
  });

  Future<Either<NetworkError, VerifyQrResponse>> verifyQR({
    required String requestId,
    required String source,
  });

  Future<Either<NetworkError, QRTransferResponse>> transferQR({
    required String requestId,
    required String toAmount,
    required String toAccount,
  });
}
