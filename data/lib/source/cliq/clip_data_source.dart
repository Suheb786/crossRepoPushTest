import 'package:data/entity/remote/user/response_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/dio.dart';

abstract class CliqDataSource {
  Future<HttpResponse<ResponseEntity>> getAlias({
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> getCliqAccountByAlias(
      {required String alias,
      required String mobileNo,
      required String iban,
      required String accountNo,
      required String swiftCode,
      required String bankCountry,
      required String transferType,
      required String cliqType,
      required bool getToken});

  Future<HttpResponse<ResponseEntity>> createCliqId({
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> addLinkAccount({
    required String aliasId,
    required String linkType,
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> changeDefaultAccount({
    required String linkType,
    required String otpCode,
    required String identifier,
    required String aliasId,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> unLinkAccountFromCliq({
    required String aliasId,
    required String accountId,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> requestMoney({
    required String cliqType,
    required String iban,
    required String toAccountNo,
    required String alias,
    required String mobile,
    required String receipentName,
    required String amount,
    required String currency,
    required String rtpPurposeCode,
    required String description,
    required String beneficiaryId,
    required String toAccountHolderName,
    required String receipentAddress,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> requestMoneyActivity({
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> editCliqID({
    required bool isAlias,
    required String aliasId,
    required String aliasValue,
    required String OtpCode,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> suspendCliqId({
    required String aliasId,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> reActivateCliqId({
    required String aliasId,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> deleteCliqId({
    required String aliasId,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> updateRTPCliqRequest({
    required String msgId,
    required String rejectReason,
    required String rejectAddInfo,
    required String dbtrBic,
    required String dbtrAcct,
    required String dbtrName,
    required String dbtrIsIndvl,
    required String cdtrBic,
    required String cdtrAcct,
    required String cdtrName,
    required String cdtrIsIndvl,
    required String rmtInf,
    required String ctgyPurp,
    required String amount,
    required String curr,
    required bool rtpStatus,
    required String otPcode,
    required String cdtrPstlAdr,
    required String dbtrPstlAdr,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> sendMoneytoCliqIBAN({
    required String otpCode,
    required String transferType,
    required String cliqType,
    required String toIban,
    required String toAccountNo,
    required String toAlias,
    required String toMobileNo,
    required String toBankCountry,
    required String swift,
    required String routingNO,
    required String recipientName,
    required String fromAccountNo,
    required String transferAmount,
    required String fromAccountCurrency,
    required String toAccountCurrency,
    required bool Charges,
    required String TransferPurposeCode,
    required String description,
    required String whenToSend,
    required String beneficiaryId,
    dynamic fromCardId,
    dynamic fromCardType,
    dynamic ownAccountTransferType,
    required String fromAccountHolderName,
    required String recipientAddress,
    required String flagAmount,
    required String flagCurrency,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> qRCliqCode({
    required String code,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> sendQRCliqPayment(
      {required String referenceLabel,
      required String merchantCategoryCode,
      required String countryCode,
      required String merchantID,
      required String merchantName,
      dynamic location,
      required String transactionAmount,
      required String city,
      required String transactionCurrency,
      required String additionalLanguageTemplate,
      dynamic verificationCode,
      required String dateTime,
      dynamic billNumber,
      dynamic mobileNumber,
      dynamic storeLabel,
      dynamic loyaltyNumber,
      dynamic customerLabel,
      dynamic terminalLabel,
      required String qrCode,
      required String crdtrBic,
      required String fromAccount,
      required String fromAccountHolderName,
      required String ValueOfConvenienceFixed,
      required String TipOrConvenienceIndicator,
      dynamic valueOfPercentageConvenience,
      required bool getToken});
}
