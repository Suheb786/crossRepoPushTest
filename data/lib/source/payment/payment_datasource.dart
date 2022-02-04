import 'package:data/entity/remote/payment/check_send_money_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_content_response_entity.dart';
import 'package:data/entity/remote/payment/payment_activity_response_entity.dart';
import 'package:data/entity/remote/payment/request_to_pay_content_response_entity.dart';
import 'package:data/entity/remote/payment/transfer_success_response_entity.dart';
import 'package:data/entity/remote/purpose/purpose_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/dio.dart';

abstract class PaymentRemoteDs {
  Future<HttpResponse<GetAccountByAliasContentResponseEntity>>
      getAccountByAlias(String value, String currency);

  Future<HttpResponse<CheckSendMoneyResponseEntity>> checkSendMoney(
      {String toAccount, num toAmount});

  Future<HttpResponse<TransferSuccessResponseEntity>> transfer(
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
      String detCustomerType,
      String type});

  Future<HttpResponse<RequestToPayContentResponseEntity>> requestToPay(
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

  Future<HttpResponse<ResponseEntity>> transferVerify();

  Future<HttpResponse<PurposeResponseEntity>> getPurpose(String toAccount,
      String transferType, String detCustomerType, String type);

  Future<HttpResponse<PaymentActivityResponseEntity>> getPaymentActivity();

  Future<HttpResponse<ResponseEntity>> payBackCreditCard(
      {String? secureCode, String? payBackAmount});
}
