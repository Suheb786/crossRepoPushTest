import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class CliqRepository {
  Future<Either<NetworkError, bool>> getAlias({
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
}
