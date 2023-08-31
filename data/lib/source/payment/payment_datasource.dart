import 'package:data/entity/remote/payment/check_send_money_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_content_response_entity.dart';
import 'package:data/entity/remote/payment/request_to_pay_content_response_entity.dart';
import 'package:data/entity/remote/payment/return_payment_activity/get_rejection_reason_response_entity.dart';
import 'package:data/entity/remote/payment/transfer_success_response_entity.dart';
import 'package:data/entity/remote/purpose/purpose_response_entity.dart';
import 'package:data/entity/remote/qr/qr_response_entity.dart';
import 'package:data/entity/remote/qr/qr_transfer_response_entity.dart';
import 'package:data/entity/remote/qr/verify_qr_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/dio.dart';

abstract class PaymentRemoteDs {
  Future<HttpResponse<GetAccountByAliasContentResponseEntity>> getAccountByAlias(
      String fromAccount, String value, String currency, String? beneficiaryId);

  Future<HttpResponse<CheckSendMoneyResponseEntity>> checkSendMoney(
      {String? fromAccount, String toAccount, num toAmount, String beneficiaryId});

  Future<HttpResponse<TransferSuccessResponseEntity>> transfer(
      {String beneficiaryId,
      String? otpCode,
      String? fromAccount,
      String transferType,
      String beneficiaryImage,
      bool isFriend,
      num toAmount,
      num localEq,
      String memo,
      String toAccount,
      String nickName,
      String detCustomerType,
      String type,
      String? recipientName,
      String? recipientAddress});

  Future<HttpResponse<RequestToPayContentResponseEntity>> requestToPay(
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
      String? addressCountry);

  Future<HttpResponse<ResponseEntity>> transferVerify({required String amount});

  Future<HttpResponse<PurposeResponseEntity>> getPurpose(
      String toAccount, String transferType, String detCustomerType, String type);

  Future<HttpResponse<ResponseEntity>> payBackCreditCard({String? secureCode, String? payBackAmount});

  Future<HttpResponse<QRResponseEntity>> generateQR({required String amount});

  Future<HttpResponse<VerifyQRResponseEntity>> verifyQR({required String requestId, required String source});

  Future<HttpResponse<QRTransferResponseEntity>> transferQR(
      {required String requestId, required String toAmount, required String toAccount, required String otp});

  Future<HttpResponse<GetRejectionReasonResponseEntity>> getReturnRejectionReason({
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> qrScanOTP();
}
