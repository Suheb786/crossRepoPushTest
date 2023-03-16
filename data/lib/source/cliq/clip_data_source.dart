import 'package:data/entity/remote/cliq/add_link_account/add_link_account_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/change_default_account_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/confirm_create_cliq_id/confirm_create_cliq_id_response_entity.dart';
import 'package:data/entity/remote/cliq/create_cliq_id_otp/create_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/delete_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id/edit_cliq_id_response_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id_otp/edit_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/get_account_by_customer_id/get_account_by_customer_id_response_entity.dart';
import 'package:data/entity/remote/cliq/get_alias/get_alias_response_entity.dart';
import 'package:data/entity/remote/cliq/re_activate_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/suspend_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/unlink_account_from_cliq/unlink_account_from_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/payment/payment_activity_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/dio.dart';

abstract class CliqDataSource {
  Future<HttpResponse<GetAliasResponseEntity>> getAlias({
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> getCliqAccountByAlias(
      {required String type,
      required String value,
      required String Currency,
      required String CustId,
      required bool GetToken});

  Future<HttpResponse<ConfirmCreateCliqIdResponseEntity>> confirmCreateCLidID({
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
    required String otpCode,
    required bool getToken,
  });

  Future<HttpResponse<CreateCliqIdOtpResponseEntity>> createCliqIdOtp({
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
    required String otpCode,
    required bool getToken,
  });

  Future<HttpResponse<AddLinkAccountOtpResponseEntity>> addLinkAccountOtp({
    required String aliasId,
    required String linkType,
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> confirmChangeDefaultAccount(
      {required String acc, required String aliasId, required String otpCode});

  Future<HttpResponse<ChangeDefaultAccountOtpResponseEntity>> changeDefaultAccountOtp({
    required String acc,
    required String aliasId,
  });

  Future<HttpResponse<ResponseEntity>> unLinkAccountFromCliq({
    required String aliasId,
    required String accountId,
    required String otpCode,
    required bool getToken,
  });

  Future<HttpResponse<UnlinkAccountFromCliqIdOtpResponseEntity>> unLinkAccountFromCliqOtp({
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

  Future<HttpResponse<PaymentActivityResponseEntity>> requestMoneyActivity({
    required int FilterDays,
    required String TransactionType,
    required bool getToken,
  });

  Future<HttpResponse<EditCliqResponseEntity>> editCliqID({
    required bool isAlias,
    required String aliasId,
    required String aliasValue,
    required String OtpCode,
    required bool getToken,
  });

  Future<HttpResponse<EditCliqOtpResponseEntity>> editCliqIdOtp({
    required String aliasId,
    required bool isAlias,
    required String aliasValue,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> suspendCliqId({
    required String aliasId,
    required String otpCode,
    required bool getToken,
  });

  Future<HttpResponse<SuspendCliqIdOtpResponseEntity>> suspendCliqIdOtp({
    required String aliasId,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> reActivateCliqId({
    required String aliasId,
    required String otpCode,
    required bool getToken,
  });

  Future<HttpResponse<ReActivateCliqIdOtpResponseEntity>> reActivateCliqIdOtp({
    required String aliasId,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> deleteCliqId({
    required String aliasId,
    required String otpCode,
    required bool getToken,
  });

  Future<HttpResponse<DeleteCliqIdOtpResponseEntity>> deleteCliqIdOtp({
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

  Future<HttpResponse<ResponseEntity>> getCustomerByAccount({
    required String accountCode,
    required String CustID,
    required bool GetToken,
  });

  Future<HttpResponse<ResponseEntity>> requestToPayResult({
    required String CustID,
    required String OrgnlMsgId,
    required String RTPStatus,
    required String RejectReason,
    required String RejectADdInfo,
  });

  Future<HttpResponse<GetAccountByCustomerIdResponseEntity>> getAccountByCustomerID();

  Future<HttpResponse<ResponseEntity>> approveRTPRequest({
    required String custID,
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
    required bool GetToken,
  });

  Future<HttpResponse<ResponseEntity>> submitOutwardPayment({
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
