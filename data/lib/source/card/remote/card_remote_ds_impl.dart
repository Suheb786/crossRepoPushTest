import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/card/cancel_credit_card_request.dart';
import 'package:data/entity/remote/card/cancel_debit_card_request.dart';
import 'package:data/entity/remote/card/card_issuance_response_entity.dart';
import 'package:data/entity/remote/card/card_statement_response_entity.dart';
import 'package:data/entity/remote/card/card_transaction_response_entity.dart';
import 'package:data/entity/remote/card/change_debit_card_pin_request.dart';
import 'package:data/entity/remote/card/confirm_creditcard_delivery_request.dart';
import 'package:data/entity/remote/card/credit_card_limits_update_request_entity.dart';
import 'package:data/entity/remote/card/credit_card_statement_request.dart';
import 'package:data/entity/remote/card/debit_card_limits_update_request_entity.dart';
import 'package:data/entity/remote/card/debit_card_statement_request.dart';
import 'package:data/entity/remote/card/debit_years_response_entity.dart';
import 'package:data/entity/remote/card/get_debit_card_transaction_request.dart';
import 'package:data/entity/remote/card/request_card_request.dart';
import 'package:data/entity/remote/card/set_card_pin_request.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/card/card_datasource.dart';
import 'package:retrofit/dio.dart';

class CardRemoteDsImpl extends CardRemoteDs {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  CardRemoteDsImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<CardIssuanceResponseEntity>>
      getCardIssuanceDetails() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCardIssuanceDetails(
        BaseRequest(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> setCardPin(String pin) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.setCardPin(SetCardPinRequest(
        baseData: baseData.toJson(), getToken: true, pinCode: pin));
  }

  @override
  Future<HttpResponse<ResponseEntity>> confirmCardDelivery() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.confirmCardDelivery(
        BaseRequest(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> confirmCreditCardDelivery() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.confirmCreditCardDelivery(
        ConfirmCreditCardDeliveryRequest(
            baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<CardTransactionResponseEntity>>
      getDebitCardTransactions() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();

    ///TODO:change value to true (getToken)
    return _apiService.getDebitCardTransactions(GetDebitCardTransactionRequest(
        baseData: baseData.toJson(), getToken: false, isDebit: true));
  }

  @override
  Future<HttpResponse<CardTransactionResponseEntity>>
      getCreditCardTransactions() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCreditCardTransactions(
        ConfirmCreditCardDeliveryRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<CardStatementResponseEntity>> getCreditCardStatement(
      {String? monthYear}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCreditCardStatement(CreditCardStatementRequest(
        baseData: baseData.toJson(), monthYear: monthYear, getToken: true));
  }

  @override
  Future<HttpResponse<DebitYearsResponseEntity>> getCreditYears() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCreditYears(
        ConfirmCreditCardDeliveryRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<CardStatementResponseEntity>> getDebitCardStatement(
      {String? monthYear}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getDebitCardStatement(DebitCardStatementRequest(
        baseData: baseData.toJson(), monthYear: monthYear, getToken: true));
  }

  @override
  Future<HttpResponse<DebitYearsResponseEntity>> getDebitYears() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getDebitYears(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> requestCreditCard(
      {required double? cardLimit}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.requestCreditCard(
        RequestCardRequest(baseData: baseData.toJson(), cardLimit: cardLimit));
  }

  @override
  Future<HttpResponse<ResponseEntity>> cancelCreditCard(
      {String? reason}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.cancelCreditCard(
        CancelCreditCardRequest(baseData: baseData.toJson(), reason: reason));
  }

  @override
  Future<HttpResponse<ResponseEntity>> creditCardPinUnBlock() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .creditCardPinUnBlock(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> freezeCreditCard() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .freezeCreditCard(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unFreezeCreditCard() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .unFreezeCreditCard(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> cancelDebitCard({String? reason}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.cancelDebitCard(
        CancelDebitCardRequest(baseData: baseData.toJson(), reason: reason));
  }

  @override
  Future<HttpResponse<ResponseEntity>> freezeDebitCard() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .freezeDebitCard(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unFreezeDebitCard() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .unFreezeDebitCard(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changeDebitCardPin(
      {String? status, required String pin}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changeDebitCardPin(
        ChangeDebitCardPinRequest(baseData: baseData.toJson(), pinCode: pin));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unblockDebitCardPin(
      {required String pin}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.unblockDebitCardPin(
        ChangeDebitCardPinRequest(baseData: baseData.toJson(), pinCode: pin));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateDebitCardLimits(
      {num? atmWithdrawal,
      num? merchantsPayments,
      num? onlinePurchase,
      num? contactLessPayments,
      bool? isAtmWithdrawal,
      bool? isMerchantsPayments,
      bool? isOnlinePurchase,
      bool? isContactLessPayments}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateDebitCardLimits(
        DebitCardSLimitsUpdateRequestEntity(
            getToken: true,
            atmWithdrawal: atmWithdrawal,
            contactLessPayments: contactLessPayments,
            merchantsPayments: merchantsPayments,
            onlinePurchase: onlinePurchase,
            isAtmWithdrawal: isAtmWithdrawal,
            isContactLessPayments: isContactLessPayments,
            isMerchantsPayments: isMerchantsPayments,
            isOnlinePurchase: isOnlinePurchase,
            baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateCreditCardLimits(
      {num? atmWithdrawal,
      num? merchantsPayments,
      num? onlinePurchase,
      num? contactLessPayments,
      bool? isAtmWithdrawal,
      bool? isMerchantsPayments,
      bool? isOnlinePurchase,
      bool? isContactLessPayments}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateCreditCardLimits(
        CreditCardSLimitsUpdateRequestEntity(
            getToken: true,
            atmWithdrawal: atmWithdrawal,
            contactLessPayments: contactLessPayments,
            merchantsPayments: merchantsPayments,
            onlinePurchase: onlinePurchase,
            isAtmWithdrawal: isAtmWithdrawal,
            isContactLessPayments: isContactLessPayments,
            isMerchantsPayments: isMerchantsPayments,
            isOnlinePurchase: isOnlinePurchase,
            baseData: baseData.toJson()));
  }
}
