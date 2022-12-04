import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

import 'package:domain/model/cliq/getAlias/get_alias.dart';

abstract class CliqRepository {
  Future<Either<NetworkError, GetAlias>> getAlias({
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> getCliqAccountByAlias({
    required String alias,
    required String mobileNo,
    required String iban,
    required String accountNo,
    required String swiftCode,
    required String bankCountry,
    required String transferType,
    required String cliqType,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> createCliqId({
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

  Future<Either<NetworkError, bool>> changeDefaultAccount({
    required String linkType,
    required String otpCode,
    required String identifier,
    required String aliasId,
    required bool getToken,
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

  Future<Either<NetworkError, bool>> requestMoneyActivity({
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> editCliqID({
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
}
