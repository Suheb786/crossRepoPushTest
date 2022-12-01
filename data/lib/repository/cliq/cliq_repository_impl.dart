import 'package:dartz/dartz.dart';
import 'package:data/db/safe_db_call.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/cliq/clip_data_source.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';

class CliqRepositoryImpl extends CliqRepository {
  final CliqDataSource _cliqDataSource;

  CliqRepositoryImpl(this._cliqDataSource);

  @override
  Future<Either<NetworkError, bool>> getAlias({required bool getToken}) async {
    final result =
        await safeApiCall(_cliqDataSource.getAlias(getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> getCliqAccountByAlias(
      {required String alias,
      required String mobileNo,
      required String iban,
      required String accountNo,
      required String swiftCode,
      required String bankCountry,
      required String transferType,
      required String cliqType,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.getCliqAccountByAlias(
        alias: alias,
        mobileNo: mobileNo,
        iban: iban,
        accountNo: accountNo,
        swiftCode: swiftCode,
        bankCountry: bankCountry,
        transferType: transferType,
        cliqType: cliqType,
        getToken: getToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> createCliqId(
      {required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.createCliqId(
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> addLinkAccount(
      {required String aliasId,
      required String linkType,
      required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.addLinkAccount(
        aliasId: aliasId,
        linkType: linkType,
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> changeDefaultAccount(
      {required String linkType,
      required String otpCode,
      required String identifier,
      required String aliasId,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.changeDefaultAccount(
        linkType: linkType,
        otpCode: otpCode,
        identifier: identifier,
        aliasId: aliasId,
        getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> editCliqID(
      {required bool isAlias,
      required String aliasId,
      required String aliasValue,
      required String OtpCode,
      required bool getToken}) async {
    final result = await safeApiCall(
      _cliqDataSource.editCliqID(
          isAlias: isAlias,
          aliasId: aliasId,
          aliasValue: aliasValue,
          OtpCode: OtpCode,
          getToken: getToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> deleteCliqId(
      {required String aliasId, required bool getToken}) async {
    final result = await safeApiCall(
        _cliqDataSource.deleteCliqId(aliasId: aliasId, getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> reActivateCliqId(
      {required String aliasId, required bool getToken}) async {
    final result = await safeApiCall(
        _cliqDataSource.reActivateCliqId(aliasId: aliasId, getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> suspendCliqId(
      {required String aliasId, required bool getToken}) async {
    final result = await safeApiCall(
        _cliqDataSource.suspendCliqId(aliasId: aliasId, getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> unLinkAccountFromCliq(
      {required String aliasId,
      required String accountId,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.unLinkAccountFromCliq(
        aliasId: aliasId, accountId: accountId, getToken: getToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> requestMoney(
      {required String cliqType,
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
      required bool getToken}) async {
    // TODO: implement requestMoney
    final result = await safeApiCall(_cliqDataSource.requestMoney(
        cliqType: cliqType,
        iban: iban,
        toAccountNo: toAccountNo,
        alias: alias,
        mobile: mobile,
        receipentName: receipentName,
        amount: amount,
        currency: currency,
        rtpPurposeCode: rtpPurposeCode,
        description: description,
        beneficiaryId: beneficiaryId,
        toAccountHolderName: toAccountHolderName,
        receipentAddress: receipentAddress,
        getToken: getToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> requestMoneyActivity(
      {required bool getToken}) async {
    final result = await safeApiCall(
        _cliqDataSource.requestMoneyActivity(getToken: getToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }
}
