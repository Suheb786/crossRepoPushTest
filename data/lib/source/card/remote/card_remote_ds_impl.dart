import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/card/cancel_credit_card_request.dart';
import 'package:data/entity/remote/card/cancel_debit_card_request_entity.dart';
import 'package:data/entity/remote/card/card_issuance_response_entity.dart';
import 'package:data/entity/remote/card/card_statement_response_entity.dart';
import 'package:data/entity/remote/card/card_transaction_response_entity.dart';
import 'package:data/entity/remote/card/change_debit_card_pin_request.dart';
import 'package:data/entity/remote/card/confirm_creditcard_delivery_request.dart';
import 'package:data/entity/remote/card/credit_card_limits_update_request_entity.dart';
import 'package:data/entity/remote/card/credit_card_statement_request.dart';
import 'package:data/entity/remote/card/debit_card_limits_update_request_entity.dart';
import 'package:data/entity/remote/card/debit_card_statement_request.dart';
import 'package:data/entity/remote/card/debit_supplementary/apply_debit_supplementary_card_request.dart';
import 'package:data/entity/remote/card/debit_years_response_entity.dart';
import 'package:data/entity/remote/card/freeze_credit_card_request_entity.dart';
import 'package:data/entity/remote/card/freeze_debit_card_request_entity.dart';
import 'package:data/entity/remote/card/get_card_application/get_card_application_response_entity.dart';
import 'package:data/entity/remote/card/get_debit_card_transaction_request.dart';
import 'package:data/entity/remote/card/get_loan_values/get_loan_values_request_entity.dart';
import 'package:data/entity/remote/card/get_loan_values/get_loan_values_response_entity.dart';
import 'package:data/entity/remote/card/link_card_step/link_card_step_request_entity.dart';
import 'package:data/entity/remote/card/process_loan_request/process_loan_request_entity.dart';
import 'package:data/entity/remote/card/process_loan_request/process_loan_response_entity.dart';
import 'package:data/entity/remote/card/request_card_request.dart';
import 'package:data/entity/remote/card/set_card_pin_request.dart';
import 'package:data/entity/remote/debit_card/debit_card_limit_request_entity.dart';
import 'package:data/entity/remote/debit_card/debit_card_limit_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/helper/encypt_decrypt_helper.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/card/card_datasource.dart';
import 'package:domain/model/user/scanned_document_information.dart';
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
  Future<HttpResponse<ResponseEntity>> setCardPin(
      String pin, String cardNumber) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.setCardPin(SetCardPinRequest(
        baseData: baseData.toJson(),
        getToken: true,
        pinCode: EncryptDecryptHelper.generateBlockPin(
            cardNo: cardNumber, pinCode: pin)));
  }

  @override
  Future<HttpResponse<ResponseEntity>> confirmCardDelivery() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.confirmCardDelivery(
        BaseRequest(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> confirmCreditCardDelivery(
      {String? cardId, String? cardDigit}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.confirmCreditCardDelivery(
        ConfirmCreditCardDeliveryRequest(
            cardId: cardId,
            accountId: '1',
            cardDigit: cardDigit,
            baseData: baseData.toJson(),
            getToken: true));
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
  Future<HttpResponse<DebitCardLimitResponseEntity>> getDebitCardLimit() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getDebitCardLimit(DebitCardLimitRequestEntity(
        getToken: false, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> requestCreditCard(
      {required String? cardId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.requestCreditCard(
        RequestCardRequest(baseData: baseData.toJson(), cardId: cardId));
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
  Future<HttpResponse<ResponseEntity>> freezeCreditCard(
      {String? cardId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.freezeCreditCard(FreezeCreditCardRequestEntity(
        cardId: cardId, getToken: true, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unFreezeCreditCard(
      {String? cardId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.unFreezeCreditCard(FreezeCreditCardRequestEntity(
        cardId: cardId, getToken: true, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> cancelDebitCard(
      {String? reason, String? status, String? tokenizedPan}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.cancelDebitCard(CancelDebitCardRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        status: status,
        tokenizedPan: tokenizedPan));
  }

  @override
  Future<HttpResponse<ResponseEntity>> freezeDebitCard(
      {String? status, String? tokenizedPan}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.freezeDebitCard(FreezeDebitCardRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        status: status,
        tokenizedPan: tokenizedPan));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unFreezeDebitCard(
      {String? status, String? tokenizedPan}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.unFreezeDebitCard(FreezeDebitCardRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        status: status,
        tokenizedPan: tokenizedPan));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changeDebitCardPin(
      {required String pin,
      required String otp,
      required String cardNumber,
      required String tokenizedPan}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    print('card No--->$cardNumber');
    return _apiService.changeDebitCardPin(ChangeDebitCardPinRequest(
        baseData: baseData.toJson(),
        pinCode: EncryptDecryptHelper.generateBlockPin(
            cardNo: cardNumber, pinCode: pin),
        otp: otp,
        tokenizedPan: tokenizedPan,
        getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unblockDebitCardPin(
      {required String pin, required String status}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.unblockDebitCardPin(ChangeDebitCardPinRequest(
        baseData: baseData.toJson(), pinCode: pin, tokenizedPan: status));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateDebitCardLimits({
    num? atmWithdrawal,
    num? merchantsPayments,
    num? onlinePurchase,
    num? contactLessPayments,
    bool? isAtmWithdrawal,
    bool? isMerchantsPayments,
    bool? isOnlinePurchase,
    bool? isContactLessPayments,
    String? tokenizedPan,
  }) async {
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
            tokenizedPan: tokenizedPan,
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

  @override
  Future<HttpResponse<GetCardApplicationResponseEntity>>
      getCardApplication() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .getCardApplication(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<GetLoanValuesResponseEntity>> getLoanValues(
      {String? accountId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getLoanValues(GetLoanValuesRequestEntity(
        getToken: true, accountId: '1', baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ProcessLoanResponseEntity>> processLoanRequest(
      {String? minimumSettlement,
      String? nickName,
      num? loanValueId,
      num? creditLimit}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.processLoanRequest(ProcessLoanRequestEntity(
        getToken: true,
        baseData: baseData.toJson(),
        loanValueId: loanValueId,
        minimumSettlement: minimumSettlement,
        nickName: nickName,
        creditLimit: creditLimit));
  }

  @override
  Future<HttpResponse<ResponseEntity>> linkCardStep(
      {String? cardId, String? accountNumber}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.linkCardStep(LinkCardStepRequestEntity(
        cardId: cardId,
        accountNumber: accountNumber,
        getToken: true,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changePinVerify() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .changePinVerify(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> applyDebitSupplementaryCard(
      {required ScannedDocumentInformation scannedDocumentInformation}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.applyDebitSupplementaryCard(
        ApplyDebitSupplementaryCardRequest(
            baseData: baseData.toJson(),
            getToken: true,
            type: "C",
            dob: scannedDocumentInformation.dob.toString(),
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            backCardImage: scannedDocumentInformation.backCardImage,
            documentCode: scannedDocumentInformation.documentCode ?? 'I',
            documentNumber: scannedDocumentInformation.documentNumber,
            doe: scannedDocumentInformation.doe.toString(),
            familyName: scannedDocumentInformation.familyName,
            firstName: scannedDocumentInformation.firstName ??
                scannedDocumentInformation.fullName!.split(' ').first,
            frontCardImage: scannedDocumentInformation.frontCardImage,
            fullName: scannedDocumentInformation.fullName,
            gender: scannedDocumentInformation.gender![0].toUpperCase(),
            idNumber: scannedDocumentInformation.idNumber,
            instanceID: scannedDocumentInformation.instanceId,
            issuer: scannedDocumentInformation.issuingPlaceISo3,
            middleName: scannedDocumentInformation.middleName,
            mrtDraw: scannedDocumentInformation.mrtDraw,
            nationality: scannedDocumentInformation.nationality,
            optionalData1: scannedDocumentInformation.optionalData1,
            optionalData2: scannedDocumentInformation.optionalData2,
            personFaceImage: scannedDocumentInformation.personFaceImage,
            scanPercentage: 0));
  }
}
