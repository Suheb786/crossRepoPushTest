import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/model/purpose/purpose_response.dart';

abstract class PaymentRepository {
  Future<Either<NetworkError, GetAccountByAliasContentResponse>>
      getAccountByAlias(String value, String currency);

  Future<Either<NetworkError, CheckSendMoneyResponse>> checkSendMoney(
      String toAccount, num toAmount);

  Future<Either<NetworkError, TransferSuccessResponse>> transfer(
      {String beneficiaryId,
      String? otpCode,
      String transferType,
      String beneficiaryImage,
      bool isFriend,
      num toAmount,
      num localEq,
      String memo,
      String toAccount});

  Future<Either<NetworkError, bool>> transferVerify();

  Future<Either<NetworkError, RequestToPayContentResponse>> requestToPay(
      String ctgyPurp,
      num amount,
      String dbtrBic,
      String dbtrAcct,
      String dbtrName,
      String memo,
      bool? isFriend,
      String? image,
      String? nickName);

  Future<Either<NetworkError, PurposeResponse>> getPurpose(
      String toAccount, String transferTypel);
}
