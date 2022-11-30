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
}
