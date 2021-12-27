import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/payment/check_send_money_request_entity.dart';
import 'package:data/entity/remote/payment/check_send_money_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_content_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_request_entity.dart';
import 'package:data/entity/remote/payment/transfer_request_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/payment/payment_datasource.dart';
import 'package:retrofit/dio.dart';

class PaymentRemoteDataSourceImpl extends PaymentRemoteDs {
  final ApiService _apiService;
  final DeviceInfoHelper deviceInfoHelper;

  PaymentRemoteDataSourceImpl(this._apiService, this.deviceInfoHelper);

  @override
  Future<HttpResponse<GetAccountByAliasContentResponseEntity>>
      getAccountByAlias(String value, String currency) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.getAccountByAlias(GetAccountByAliasRequestEntity(
        baseData: baseData.toJson(),
        value: value,
        currency: currency,
        getToken: true));
  }

  @override
  Future<HttpResponse<CheckSendMoneyResponseEntity>> checkSendMoney(
      {String? toAccount, num? toAmount}) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.checkSendMoney(CheckSendMoneyRequestEntity(
        baseData: baseData.toJson(),
        toAccount: toAccount,
        toAmount: toAmount,
        getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> transfer(
      {String? beneficiaryId,
      String? transferType,
      String? beneficiaryImage,
      bool? isFriend,
      num? toAmount,
      num? localEq,
      String? memo,
      String? toAccount}) async {
    BaseClassEntity baseData = await deviceInfoHelper.getDeviceInfo();
    return _apiService.transfer(TransferRequestEntity(
        baseData: baseData.toJson(),
        toAmount: toAmount!,
        toAccount: toAccount!,
        beneficiaryId: DateTime.now().microsecondsSinceEpoch.toString(),
        beneficiaryImage: beneficiaryImage,
        isFriend: isFriend!,
        localEq: localEq!,
        memo: memo!,
        transferType: transferType!,
        getToken: true));
  }
}
