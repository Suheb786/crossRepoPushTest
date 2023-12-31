import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/card/account_card_statement_response_entity.dart';
import 'package:data/entity/remote/card/cancel_credit_card_request.dart';
import 'package:data/entity/remote/card/cancel_debit_card_request_entity.dart';
import 'package:data/entity/remote/card/card_in_process/get_card_in_process_request_entity.dart';
import 'package:data/entity/remote/card/card_issuance_response_entity.dart';
import 'package:data/entity/remote/card/card_statement_response_entity.dart';
import 'package:data/entity/remote/card/card_transaction_response_entity.dart';
import 'package:data/entity/remote/card/cc_change_linked_mobile_number/cc_change_mobile_number_request_entity.dart';
import 'package:data/entity/remote/card/cc_change_linked_mobile_number/cc_change_mobile_number_verify_request_entity.dart';
import 'package:data/entity/remote/card/cc_new_settlement/cc_update_settlement_request_entity.dart';
import 'package:data/entity/remote/card/change_credit_card_pin/change_credit_card_pin_request_entity.dart';
import 'package:data/entity/remote/card/change_credit_card_pin/change_credit_card_pin_verify_request_entity.dart';
import 'package:data/entity/remote/card/change_credit_card_pin/unblock_credit_card_pin_request_entity.dart';
import 'package:data/entity/remote/card/change_debit_card_pin_request.dart';
import 'package:data/entity/remote/card/credit_card_limits_update_request_entity.dart';
import 'package:data/entity/remote/card/credit_card_relationship/credit_card_relationship_response_entity.dart';
import 'package:data/entity/remote/card/credit_card_statement_request.dart';
import 'package:data/entity/remote/card/credit_card_video_call/credit_card_call_status_update_request.dart';
import 'package:data/entity/remote/card/credit_supplementary/get_credit_card_relationship_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/get_supplementary_credit_card_application_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_application_response_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_request_response_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_step_three_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_step_two_request_entity.dart';
import 'package:data/entity/remote/card/dc_change_linked_mobile_number/dc_change_mobile_number_request_entity.dart';
import 'package:data/entity/remote/card/dc_change_linked_mobile_number/dc_change_mobile_number_verify_request_entity.dart';
import 'package:data/entity/remote/card/debit_card_limits_update_request_entity.dart';
import 'package:data/entity/remote/card/debit_card_statement_request.dart';
import 'package:data/entity/remote/card/debit_supplementary/apply_debit_supplementary_card_request.dart';
import 'package:data/entity/remote/card/debit_supplementary/remove_or_reapply_supplementary_debit_card_request_entity.dart';
import 'package:data/entity/remote/card/debit_years_response_entity.dart';
import 'package:data/entity/remote/card/freeze_credit_card_request_entity.dart';
import 'package:data/entity/remote/card/freeze_debit_card_request_entity.dart';
import 'package:data/entity/remote/card/get_card_application/get_card_application_response_entity.dart';
import 'package:data/entity/remote/card/get_credit_card_transaction_list_request_entity.dart';
import 'package:data/entity/remote/card/get_debit_card_transaction_request.dart';
import 'package:data/entity/remote/card/get_loan_values/get_loan_values_request_entity.dart';
import 'package:data/entity/remote/card/get_loan_values/get_loan_values_response_entity.dart';
import 'package:data/entity/remote/card/link_card_step/link_card_step_request_entity.dart';
import 'package:data/entity/remote/card/process_loan_request/process_loan_request_entity.dart';
import 'package:data/entity/remote/card/report_stolen_cc/report_stolen_cc_request_entity.dart';
import 'package:data/entity/remote/card/request_card_request.dart';
import 'package:data/entity/remote/card/set_card_pin_request.dart';
import 'package:data/entity/remote/card/unblock_debit_card_pin_request.dart';
import 'package:data/entity/remote/credit_card_limit/get_credit_card_limit_request_entity.dart';
import 'package:data/entity/remote/credit_card_limit/get_credit_card_limit_response_entity.dart';
import 'package:data/entity/remote/debit_card/debit_card_limit_request_entity.dart';
import 'package:data/entity/remote/debit_card/debit_card_limit_response_entity.dart';
import 'package:data/entity/remote/debit_card/request_physical_debit_card/request_physical_debit_card_request_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/helper/encypt_decrypt_helper.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/card/card_datasource.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/usecase/card_delivery/report_lost_stolen_cc_usecase.dart';
import 'package:retrofit/dio.dart';

class CardRemoteDsImpl extends CardRemoteDs {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  CardRemoteDsImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<CardIssuanceResponseEntity>> getCardIssuanceDetails() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCardIssuanceDetails(BaseRequest(baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> setCardPin(String pin, String cardNumber) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.setCardPin(SetCardPinRequest(
        baseData: baseData.toJson(),
        getToken: true,
        pinCode: EncryptDecryptHelper.generateBlockPin(cardNo: cardNumber, pinCode: pin)));
  }

  @override
  Future<HttpResponse<CardTransactionResponseEntity>> getDebitCardTransactions(
      {num? noOfDays, String? accountNo}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getDebitCardTransactions(GetDebitCardTransactionRequest(
        accountNo: accountNo,
        baseData: baseData.toJson(),
        getToken: true,
        isDebit: true,
        noOfDays: noOfDays));
  }

  @override
  Future<HttpResponse<CardTransactionResponseEntity>> getCreditCardTransactions(
      {required String cardId,
      num? noOfDays,
      required String secureCode,
      required bool isIssuedFromCMS}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCreditCardTransactions(GetCreditCardTransactionListRequestEntity(
        issuedFromCms: isIssuedFromCMS,
        secureCode: secureCode,
        baseData: baseData.toJson(),
        cardId: cardId,
        noOfDays: noOfDays));
  }

  @override
  Future<HttpResponse<CardStatementResponseEntity>> getCreditCardStatement(
      {String? monthYear, String? cardId, String? secureCode, bool? issuedFromCms}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCreditCardStatement(CreditCardStatementRequest(
        secureCode: secureCode,
        baseData: baseData.toJson(),
        date: monthYear,
        getToken: true,
        issuedFromCms: issuedFromCms,
        cardId: cardId));
  }

  @override
  Future<HttpResponse<DebitYearsResponseEntity>> getCreditYears() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCreditYears(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<AccountCardStatementResponseEntity>> getDebitCardStatement(
      {String? monthYear, String? accountNo}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getDebitCardStatement(DebitCardStatementRequest(
        baseData: baseData.toJson(), monthYear: monthYear, getToken: true, accountNo: accountNo));
  }

  @override
  Future<HttpResponse<DebitYearsResponseEntity>> getDebitYears() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getDebitYears(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<DebitCardLimitResponseEntity>> getDebitCardLimit(
      {required String? tokenizedPan}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getDebitCardLimit(
        DebitCardLimitRequestEntity(tokenizedPan: tokenizedPan, getToken: true, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> requestCreditCard({required String? cardId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.requestCreditCard(RequestCardRequest(baseData: baseData.toJson(), cardId: cardId));
  }

  @override
  Future<HttpResponse<ResponseEntity>> cancelCreditCard({String? reason}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.cancelCreditCard(CancelCreditCardRequest(baseData: baseData.toJson(), reason: reason));
  }

  @override
  Future<HttpResponse<ResponseEntity>> creditCardPinUnBlock() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.creditCardPinUnBlock(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> freezeCreditCard(
      {String? cardId, String? secureCode, bool? isIssuedFromCMS}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.freezeCreditCard(FreezeCreditCardRequestEntity(
        cardId: cardId,
        getToken: true,
        baseData: baseData.toJson(),
        secureCode: secureCode,
        issuedFromCms: isIssuedFromCMS));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unFreezeCreditCard(
      {String? cardId, String? secureCode, bool? isIssuedFromCMS}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.unFreezeCreditCard(FreezeCreditCardRequestEntity(
        cardId: cardId,
        getToken: true,
        baseData: baseData.toJson(),
        secureCode: secureCode,
        issuedFromCms: isIssuedFromCMS));
  }

  @override
  Future<HttpResponse<ResponseEntity>> cancelDebitCard(
      {String? reason, String? status, String? tokenizedPan, String? cancellationReason}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.cancelDebitCard(CancelDebitCardRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        status: status,
        cancellationReason: cancellationReason,
        tokenizedPan: tokenizedPan));
  }

  @override
  Future<HttpResponse<ResponseEntity>> freezeDebitCard({String? status, String? tokenizedPan}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.freezeDebitCard(FreezeDebitCardRequestEntity(
        baseData: baseData.toJson(), getToken: true, status: status, tokenizedPan: tokenizedPan));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unFreezeDebitCard({String? status, String? tokenizedPan}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.unFreezeDebitCard(FreezeDebitCardRequestEntity(
        baseData: baseData.toJson(), getToken: true, status: status, tokenizedPan: tokenizedPan));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changeDebitCardPin(
      {required String pin,
      required String otp,
      required String cardNumber,
      required String tokenizedPan}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changeDebitCardPin(ChangeDebitCardPinRequest(
        otp: otp,
        pinCode: EncryptDecryptHelper.generateBlockPin(cardNo: cardNumber, pinCode: pin),
        baseData: baseData.toJson(),
        tokenizedPan: tokenizedPan,
        getToken: true));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unblockDebitCardPin(
      {required String pin, required String status}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.unblockDebitCardPin(
        UnblockDebitCardPinRequest(baseData: baseData.toJson(), tokenizedPan: status, getToken: true));
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
      bool? isContactLessPayments,
      String? tokenizedPan,
      bool? updateEcom}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateDebitCardLimits(DebitCardSLimitsUpdateRequestEntity(
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
        updateEcom: updateEcom,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateCreditCardLimits({
    num? atmWithdrawal,
    num? merchantsPayments,
    num? onlinePurchase,
    num? contactlessPaymentLimit,
    bool? isAtmWithdrawal,
    bool? isMerchantsPayments,
    bool? isOnlinePurchase,
    bool? isContactLessPayments,
    String? secureCode,
  }) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateCreditCardLimits(CreditCardSLimitsUpdateRequestEntity(
        getToken: true,
        atmWithdrawal: atmWithdrawal,
        merchantsPayments: merchantsPayments,
        onlinePurchase: onlinePurchase,
        contactLessPaymentLimit: contactlessPaymentLimit,
        isAtmWithdrawal: isAtmWithdrawal,
        isContactLessPayments: isContactLessPayments,
        isMerchantsPayments: isMerchantsPayments,
        isOnlinePurchase: isOnlinePurchase,
        secureCode: secureCode,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<GetCardApplicationResponseEntity>> getCardApplication() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCardApplication(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<GetLoanValuesResponseEntity>> getLoanValues({String? accountId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getLoanValues(
        GetLoanValuesRequestEntity(getToken: true, accountId: '1', baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> processLoanRequest({String? cardId, num? loanValueId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.processLoanRequest(ProcessLoanRequestEntity(
        getToken: true, baseData: baseData.toJson(), loanValueId: loanValueId, cardId: cardId));
  }

  @override
  Future<HttpResponse<ResponseEntity>> linkCardStep({String? cardId, String? accountNumber}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.linkCardStep(LinkCardStepRequestEntity(
        cardId: cardId, accountNumber: accountNumber, getToken: true, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changePinVerify() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changePinVerify(BaseRequest(baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<CardIssuanceResponseEntity>> applyDebitSupplementaryCard(
      {required ScannedDocumentInformation scannedDocumentInformation,
      required String relation,
      required String nickName}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.applyDebitSupplementaryCard(ApplyDebitSupplementaryCardRequest(
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
        firstName:
            scannedDocumentInformation.firstName ?? scannedDocumentInformation.fullName!.split(' ').first,
        frontCardImage: scannedDocumentInformation.frontCardImage,
        fullName: scannedDocumentInformation.fullName,
        gender: scannedDocumentInformation.gender![0].toUpperCase(),
        idNumber: scannedDocumentInformation.idNumber,
        instanceID: scannedDocumentInformation.instanceId,
        issuer: scannedDocumentInformation.issuingPlaceISo3,
        middleName: scannedDocumentInformation.middleName,
        mrtDraw: scannedDocumentInformation.mrtDraw,
        nationality: scannedDocumentInformation.issuer,
        optionalData1: scannedDocumentInformation.optionalData1,
        optionalData2: scannedDocumentInformation.optionalData2,
        personFaceImage: scannedDocumentInformation.personFaceImage,
        scanPercentage: 0,
        nickName: nickName,
        relation: relation));
  }

  @override
  Future<HttpResponse<SupplementaryCreditCardApplicationResponseEntity>>
      getSupplementaryCreditCardApplication({required String primaryCard}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getSupplementaryCreditCardApplication(
        GetSupplementaryCreditCardApplicationRequestEntity(
            baseData: baseData.toJson(), primaryCard: primaryCard, getToken: true));
  }

  @override
  Future<HttpResponse<SupplementaryCreditCardRequestResponseEntity>> supplementaryCreditCardRequest(
      {required String primaryCardId,
      required String relationship,
      doi,
      required String type,
      required String fullName,
      required String firstName,
      required String middleName,
      required String familyName,
      required String idNumber,
      required String dob,
      required String doe,
      required String gender,
      required String documentCode,
      required String issuer,
      required String nationality,
      required String optionalData1,
      required String optionalData2,
      required String mrtDraw,
      required String frontCardImage,
      required String backCardImage,
      required String documentNumber,
      required String nickName,
      required bool sameLimit,
      required num limit}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.supplementaryCreditCardRequest(SupplementaryCreditCardRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        limit: limit,
        nationality: nationality,
        gender: gender,
        fullName: fullName,
        firstName: firstName,
        dob: dob,
        type: type,
        nickName: nickName,
        backCardImage: backCardImage,
        documentCode: documentCode,
        documentNumber: documentNumber,
        doe: doe,
        doi: doi,
        familyName: familyName,
        frontCardImage: frontCardImage,
        idNumber: idNumber,
        issuer: issuer,
        middleName: middleName,
        mrtDraw: mrtDraw,
        optionalData1: optionalData1,
        optionalData2: optionalData2,
        primaryCardId: primaryCardId,
        relationship: relationship,
        sameLimit: sameLimit));
  }

  @override
  Future<HttpResponse<ResponseEntity>> supplementaryCreditCardStepTwo(
      {required String primaryCardId, required String secondaryCardId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.supplementaryCreditCardStepTwo(SupplementaryCreditCardStepTwoRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        primaryCardId: primaryCardId,
        secondaryCardId: secondaryCardId));
  }

  @override
  Future<HttpResponse<ResponseEntity>> supplementaryCreditCardStepThree(
      {required String primaryCardId, required String secondaryCardId, required String accountNumber}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.supplementaryCreditCardStepThree(SupplementaryCreditCardStepThreeRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        primaryCardId: primaryCardId,
        secondaryCardId: secondaryCardId,
        accountNumber: accountNumber));
  }

  @override
  Future<HttpResponse<CreditCardRelationshipResponseEntity>> getCreditCardRelationShipList(
      {required String cardId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCreditCardRelationShipList(
        GetCreditCardRelationshipRequestEntity(baseData: baseData.toJson(), getToken: true, cardId: cardId));
  }

  @override
  Future<HttpResponse<ResponseEntity>> callStatusUpdate({String? cardId, String? status}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.callStatusUpdate(CreditCardCallStatusUpdateRequest(
        baseData: baseData.toJson(), cardId: cardId, getToken: true, status: status));
  }

  @override
  Future<HttpResponse<ResponseEntity>> dcChangeLinkedMobileNumberVerify({required params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.dcChangeLinkedMobileNumberVerify(DcChangeMobileNumberVerifyRequestEntity(
        baseData: baseData.toJson(),
        mobileNumber: params.mobileNumber,
        getToken: true,
        mobileCode: params.mobileCode,
        tokenizedPan: params.tokenizedPan));
  }

  @override
  Future<HttpResponse<ResponseEntity>> dcChangeLinkedMobileNumber({required params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.dcChangeLinkedMobileNumber(DcChangeMobileNumberRequestEntity(
        baseData: baseData.toJson(),
        mobileNumber: params.mobileNumber,
        otpCode: params.otpCode,
        getToken: true,
        mobileCode: params.mobileCode,
        tokenizedPan: params.tokenizedPan));
  }

  @override
  Future<HttpResponse<ResponseEntity>> ccChangeLinkedMobileNumberVerify({required params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.ccChangeLinkedMobileNumberVerify(CcChangeMobileNumberVerifyRequestEntity(
        baseData: baseData.toJson(),
        mobileNumber: params.mobileNumber,
        getToken: true,
        mobileCode: params.mobileCode,
        tokenizedPan: params.tokenizedPan));
  }

  @override
  Future<HttpResponse<ResponseEntity>> ccChangeLinkedMobileNumber({required params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.ccChangeLinkedMobileNumber(CcChangeMobileNumberRequestEntity(
        baseData: baseData.toJson(),
        mobileNumber: params.mobileNumber,
        otpCode: params.otpCode,
        getToken: true,
        mobileCode: params.mobileCode,
        tokenizedPan: params.tokenizedPan));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateSettlement({required params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateSettlement(CcUpdateSettlementRequestEntity(
        baseData: baseData.toJson(),
        cardId: params.cardId,
        rate: params.rate,
        getToken: true,
        issuedFromCms: params.isIssuedFromCMS,
        secureCode: params.secureCode));
  }

  @override
  Future<HttpResponse<GetCreditCardLimitResponseEntity>> getCreditCardLimit(
      {required String? secureCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCreditCardLimit(
        CreditCardLimitRequestEntity(secureCode: secureCode, getToken: true, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> reportLostStolenCC({ReportLostStolenCCUseCaseParams? params}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.reportLostStolenCC(ReportStolenCCRequestEntity(
        cardCode: params!.cardCode,
        panGenerationMode: params.panGenerationMode,
        replaceReason: params.replacementReason,
        getToken: true,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<CardIssuanceResponseEntity>> removeOrReApplySupplementaryDebitCardWithResponse(
      {required String status, required String tokenizedPan, required bool reApply}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.removeOrReApplySupplementaryDebitCardwithResponse(
        RemoveOrReApplySupplementaryDebitCardRequestEnity(
            baseData: baseData.toJson(),
            getToken: true,
            status: status,
            tokenizedPan: tokenizedPan,
            reApply: reApply));
  }

  @override
  Future<HttpResponse<ResponseEntity>> removeOrReApplySupplementaryDebitCard(
      {required String status, required String tokenizedPan, required bool reApply}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.removeOrReApplySupplementaryDebitCard(
        RemoveOrReApplySupplementaryDebitCardRequestEnity(
            baseData: baseData.toJson(),
            getToken: true,
            status: status,
            tokenizedPan: tokenizedPan,
            reApply: reApply));
  }

  @override
  Future<HttpResponse<ResponseEntity>> getCardInProcess(
      {String? minimumSettlement, String? nickName, num? loanValueId, num? creditLimit}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCardInProcess(GetCardInProcessRequestEntity(
        getToken: true,
        baseData: baseData.toJson(),
        loanValueId: loanValueId,
        minimumSettlement: minimumSettlement,
        nickName: nickName,
        creditLimit: creditLimit));
  }

  @override
  Future<HttpResponse<ResponseEntity>> requestPhysicalDebitCard({required String tokenizedPan}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.requestPhysicalDebitCard(RequestPhysicalDebitCardRequestEntity(
        getToken: true, baseData: baseData.toJson(), tokenizedPan: tokenizedPan));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changeCreditCardPin(
      {required String cardCode,
      required String pin,
      required String cardNumber,
      required String otp}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changeCreditCardPin(ChangeCreditCardPinRequestEntity(
        getToken: true,
        otp: otp,
        baseData: baseData.toJson(),
        cardCode: cardCode,
        encryptedCardNumber: EncryptDecryptHelper.encryptCard(cardNo: cardNumber),
        encryptedPinCode:
            EncryptDecryptHelper.generateBlockPinForCreditCard(cardNo: cardNumber, pinCode: pin)));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changeCreditCardPinVerify({required String cardCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changeCreditPinVerify(ChangeCreditCardPinVerifyRequestEntity(
        getToken: true, baseData: baseData.toJson(), cardCode: cardCode));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unblockCreditCardPin({required String cardCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.unblockCreditCardPin(
        UnblockCreditCardPinRequestEntity(getToken: true, baseData: baseData.toJson(), cardCode: cardCode));
  }
}
