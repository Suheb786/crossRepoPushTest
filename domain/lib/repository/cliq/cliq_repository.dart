import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/create_cliq_id/confirm_create_cliq_id.dart';
import 'package:domain/model/cliq/create_cliq_id/create_cliq_id_otp.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity.dart';

abstract class CliqRepository {
  Future<Either<NetworkError, GetAlias>> getAlias({
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> getCliqAccountByAlias({
    required String type,
    required String value,
    required String Currency,
    required String CustID,
    required bool GetToken,
  });

  Future<Either<NetworkError, ConfirmCreateCliqId>> confirmCreateCLidID({
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
    required String otpCode,
    required bool getToken,
  });

  Future<Either<NetworkError, CreateCliqOtp>> createCliqIdOtp({
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> addLinkAccount({
    required String aliasId,
    required String linkType,
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> confirmChangeDefaultAccount({
    required bool GetToken,
  });

  Future<Either<NetworkError, bool>> unLinkAccountFromCliq({
    required String aliasId,
    required String accountId,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> requestMoney({
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

  Future<Either<NetworkError, RequestMoneyActivity>> requestMoneyActivity({
    required bool getToken,
  });

  Future<Either<NetworkError, EditCliq>> editCliqID({
    required bool isAlias,
    required String aliasId,
    required String aliasValue,
    required String OtpCode,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> suspendCliqId({
    required String aliasId,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> reActivateCliqId({
    required String aliasId,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> deleteCliqId({
    required String aliasId,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> updateRTPCliqRequest({
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

  Future<Either<NetworkError, bool>> sendMoneytoCliqIBAN({
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

  Future<Either<NetworkError, bool>> qRCliqCode({
    required String code,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> sendQRCliqPayment(
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

  Future<Either<NetworkError, EditCliqOtp>> editCliqIdOtp({
    required String aliasId,
    required bool isAlias,
    required String aliasValue,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> getCustomerByAccount({
    required String accountCode,
    required String CustID,
    required bool GetToken,
  });

  Future<Either<NetworkError, bool>> requestToPayResult({
    required String CustID,
    required String OrgnlMsgId,
    required String RTPStatus,
    required String RejectReason,
    required String RejectADdInfo,
  });

  Future<Either<NetworkError, bool>> getAccountByCustomerID();

  Future<Either<NetworkError, bool>> changeDefaultAccountOtp({
    required bool GetToken,
  });

  Future<Either<NetworkError, bool>> approveRTPRequest(
      {required String custID,
      required String dbtrAcct,
      required String dbtrName,
      required String dbtrPstlAdr,
      required String dbtrRecordID,
      required String dbtrAlias,
      required String currency,
      required String amount,
      required String cdtrBic,
      required String cdtrName,
      required String cdtrAcct,
      required String cdtrPstlAdr,
      required String cdtrRecordID,
      required String cdtrAlias,
      required String rgltryRptg,
      required String payRefNo,
      required String rejectReason,
      required String rejectADdInfo,
      required String rtpStatus,
      required bool GetToken});

  Future<Either<NetworkError, bool>> submitOutwardPayment({
    required String custID,
    required String dbtrAcct,
    required String dbtrName,
    required String dbtrPstlAdr,
    required String dbtrRecordID,
    required String dbtrAlias,
    required String currency,
    required String amount,
    required String purposE_CODE,
    required String cdtrBic,
    required String cdtrName,
    required String cdtrAcct,
    required String cdtrPstlAdr,
    required String cdtrRecordID,
    required String cdtrAlias,
    required String rgltryRptg,
    required String CustIDTO,
    required String DbtrIsIndvl,
    required String CdtrIsIndvl,
    required String RmtInf,
    required String QRFlag,
    required bool GetToken,
  });
}
