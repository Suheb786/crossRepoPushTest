import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/cliq/clip_data_source.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/add_link_account/add_link_account_otp.dart';
import 'package:domain/model/cliq/change_default_account/change_default_account_otp.dart';
import 'package:domain/model/cliq/create_cliq_id/confirm_create_cliq_id.dart';
import 'package:domain/model/cliq/create_cliq_id/create_cliq_id_otp.dart';
import 'package:domain/model/cliq/delete_cliq_id/delete_cliq_id_otp.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:domain/model/cliq/get_account_by_customer_id/get_account_by_customer_id.dart';
import 'package:domain/model/cliq/re_activate_cliq_id/re_activate_cliq_id_otp.dart';
import 'package:domain/model/cliq/suspend_cliq_id/suspend_cliq_id_otp.dart';
import 'package:domain/model/cliq/unlink_cliq_id/unlink_cliq_id_otp.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';

class CliqRepositoryImpl extends CliqRepository {
  final CliqDataSource _cliqDataSource;

  CliqRepositoryImpl(this._cliqDataSource);

  @override
  Future<Either<NetworkError, GetAlias>> getAlias({required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.getAlias(getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, PaymentActivityResponse>> requestMoneyActivity({
    required bool getToken,
    required int FilterDays,
    required String TransactionType,
  }) async {
    final result = await safeApiCall(_cliqDataSource.requestMoneyActivity(
        getToken: getToken, FilterDays: FilterDays, TransactionType: TransactionType));
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, ConfirmCreateCliqId>> confirmCreateCLidID(
      {required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required String otpCode,
      required bool getToken,
      required bool isSetDefault}) async {
    final result = await safeApiCall(_cliqDataSource.confirmCreateCLidID(
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        otpCode: otpCode,
        getToken: getToken,
        isSetDefault: isSetDefault));

    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, CreateCliqOtp>> createCliqIdOtp(
      {required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.createCliqIdOtp(
        accountNumber: accountNumber, isAlias: isAlias, aliasValue: aliasValue, getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, bool>> addLinkAccount(
      {required String aliasId,
      required String linkType,
      required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required String otpCode,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.addLinkAccount(
        aliasId: aliasId,
        linkType: linkType,
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        otpCode: otpCode,
        getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, AddLinkAccountOtp>> addLinkAccountOtp(
      {required String aliasId,
      required String linkType,
      required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.addLinkAccountOtp(
        aliasId: aliasId,
        linkType: linkType,
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, bool>> confirmChangeDefaultAccount(
      {required String acc, required String aliasId, required String otpCode}) async {
    final result = await safeApiCall(
        _cliqDataSource.confirmChangeDefaultAccount(acc: acc, aliasId: aliasId, otpCode: otpCode));

    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, EditCliq>> editCliqID(
      {required bool isAlias,
      required String aliasId,
      required String aliasValue,
      required String OtpCode,
      required bool getToken}) async {
    final result = await safeApiCall(
      _cliqDataSource.editCliqID(
          isAlias: isAlias, aliasId: aliasId, aliasValue: aliasValue, OtpCode: OtpCode, getToken: getToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> deleteCliqId(
      {required String aliasId, required String otpCode, required bool getToken}) async {
    final result = await safeApiCall(
        _cliqDataSource.deleteCliqId(aliasId: aliasId, otpCode: otpCode, getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, DeleteCliqIdOtp>> deleteCliqIdOtp(
      {required String aliasId, required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.deleteCliqIdOtp(aliasId: aliasId, getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> reActivateCliqId(
      {required String aliasId, required String otpCode, required bool getToken}) async {
    final result = await safeApiCall(
        _cliqDataSource.reActivateCliqId(aliasId: aliasId, getToken: getToken, otpCode: otpCode));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, ReActivateCliqIdOtp>> reActivateCliqIdOtp(
      {required String aliasId, required bool getToken}) async {
    final result =
        await safeApiCall(_cliqDataSource.reActivateCliqIdOtp(aliasId: aliasId, getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> suspendCliqId(
      {required String aliasId, required String otpCode, required bool getToken}) async {
    final result = await safeApiCall(
        _cliqDataSource.suspendCliqId(aliasId: aliasId, otpCode: otpCode, getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, SuspendCliqIdOtp>> suspendCliqIdOtp(
      {required String aliasId, required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.suspendCliqIdOtp(aliasId: aliasId, getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> unLinkAccountFromCliq(
      {required String aliasId,
      required String accountId,
      required String otpCode,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.unLinkAccountFromCliq(
        aliasId: aliasId, accountId: accountId, otpCode: otpCode, getToken: getToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, UnlinkCliqIdOtp>> unLinkAccountFromCliqOtp(
      {required String aliasId, required String accountId, required bool getToken}) async {
    final result = await safeApiCall(
        _cliqDataSource.unLinkAccountFromCliqOtp(aliasId: aliasId, accountId: accountId, getToken: getToken));
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, bool>> updateRTPCliqRequest(
      {required String msgId,
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
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.updateRTPCliqRequest(
        msgId: msgId,
        rejectReason: rejectReason,
        rejectAddInfo: rejectAddInfo,
        dbtrBic: dbtrBic,
        dbtrAcct: dbtrAcct,
        dbtrName: dbtrName,
        dbtrIsIndvl: dbtrIsIndvl,
        cdtrBic: cdtrBic,
        cdtrAcct: cdtrAcct,
        cdtrName: cdtrName,
        cdtrIsIndvl: cdtrIsIndvl,
        rmtInf: rmtInf,
        ctgyPurp: ctgyPurp,
        amount: amount,
        curr: curr,
        rtpStatus: rtpStatus,
        otPcode: otPcode,
        cdtrPstlAdr: cdtrPstlAdr,
        dbtrPstlAdr: dbtrPstlAdr,
        getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, EditCliqOtp>> editCliqIdOtp(
      {required String aliasId,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.editCliqIdOtp(
        aliasId: aliasId, isAlias: isAlias, aliasValue: aliasValue, getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, bool>> requestToPayResult(
      {required String CustID,
      required String OrgnlMsgId,
      required String RTPStatus,
      required String RejectReason,
      required String RejectADdInfo,
      required bool GetToken}) async {
    final result = await safeApiCall(
      _cliqDataSource.requestToPayResult(
        CustID: CustID,
        OrgnlMsgId: OrgnlMsgId,
        RTPStatus: RTPStatus,
        RejectReason: RejectReason,
        RejectADdInfo: RejectADdInfo,
        GetToken: GetToken,
      ),
    );
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, List<GetAccountByCustomerId>>> getAccountByCustomerID() async {
    final result = await safeApiCall(_cliqDataSource.getAccountByCustomerID());
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, ChangeDefaultAccountOtp>> changeDefaultAccountOtp(
      {required String acc, required String aliasId}) async {
    final result = await safeApiCall(_cliqDataSource.changeDefaultAccountOtp(acc: acc, aliasId: aliasId));
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, bool>> approveRTPRequest({
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
    required String OrgnlMsgId,
    required String CtgyPurp,
    required String rejectReason,
    required String rejectADdInfo,
    required String rtpStatus,
    required bool GetToken,
  }) async {
    final result = await safeApiCall(_cliqDataSource.approveRTPRequest(
        custID: custID,
        dbtrAcct: dbtrAcct,
        dbtrName: dbtrName,
        dbtrPstlAdr: dbtrPstlAdr,
        dbtrRecordID: dbtrRecordID,
        dbtrAlias: dbtrAlias,
        currency: currency,
        amount: amount,
        cdtrBic: cdtrBic,
        cdtrName: cdtrName,
        cdtrAcct: cdtrAcct,
        cdtrPstlAdr: cdtrPstlAdr,
        cdtrRecordID: cdtrRecordID,
        cdtrAlias: cdtrAlias,
        rgltryRptg: rgltryRptg,
        payRefNo: payRefNo,
        OrgnlMsgId: OrgnlMsgId,
        CtgyPurp: CtgyPurp,
        rejectReason: rejectReason,
        rejectADdInfo: rejectADdInfo,
        rtpStatus: rtpStatus,
        GetToken: GetToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> submitOutwardPayment(
      {required String custID,
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
      required bool GetToken}) async {
    final result = await safeApiCall(_cliqDataSource.submitOutwardPayment(
        custID: custID,
        dbtrAcct: dbtrAcct,
        dbtrName: dbtrName,
        dbtrPstlAdr: dbtrPstlAdr,
        dbtrRecordID: dbtrRecordID,
        dbtrAlias: dbtrAlias,
        currency: currency,
        amount: amount,
        purposE_CODE: purposE_CODE,
        cdtrBic: cdtrBic,
        cdtrName: cdtrName,
        cdtrAcct: cdtrAcct,
        cdtrPstlAdr: cdtrPstlAdr,
        cdtrRecordID: cdtrRecordID,
        cdtrAlias: cdtrAlias,
        rgltryRptg: rgltryRptg,
        CustIDTO: CustIDTO,
        DbtrIsIndvl: DbtrIsIndvl,
        CdtrIsIndvl: CdtrIsIndvl,
        RmtInf: RmtInf,
        QRFlag: QRFlag,
        GetToken: GetToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }
}
