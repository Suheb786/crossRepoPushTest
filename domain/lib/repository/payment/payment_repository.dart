import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';

abstract class PaymentRepository {
  Future<Either<NetworkError, GetAccountByAliasContentResponse>>
      getAccountByAlias(String value, String currency);

  Future<Either<NetworkError, CheckSendMoneyResponse>> checkSendMoney(
      String toAccount, num toAmount);

  Future<Either<NetworkError, bool>> transfer(
      String beneficiaryId,
      String transferType,
      String beneficiaryImage,
      bool isFriend,
      num toAmount,
      num localEq,
      String memo,
      String toAccount);
}
