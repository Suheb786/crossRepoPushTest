import 'package:data/entity/remote/payment/check_send_money_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_content_response_entity.dart';
import 'package:retrofit/dio.dart';

abstract class PaymentRemoteDs {
  Future<HttpResponse<GetAccountByAliasContentResponseEntity>>
      getAccountByAlias(String value, String currency);

  Future<HttpResponse<CheckSendMoneyResponseEntity>> checkSendMoney(
      {String toAccount, num toAmount});
}
