import 'package:dartz/dartz.dart';
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
import 'package:domain/model/cliq/rejection_reason_inward_request/rejection_reason_inward.dart';
import 'package:domain/model/cliq/suspend_cliq_id/suspend_cliq_id_otp.dart';
import 'package:domain/model/cliq/unlink_cliq_id/unlink_cliq_id_otp.dart';
import 'package:domain/model/payment/payment_activity_response.dart';

abstract class CliqRepository {
  Future<Either<NetworkError, GetAlias>> getAlias({
    required bool getToken,
  });

  Future<Either<NetworkError, ConfirmCreateCliqId>> confirmCreateCLidID({
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
    required String otpCode,
    required bool getToken,
    required bool isSetDefault,
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
    required String otpCode,
    required bool getToken,
  });

  Future<Either<NetworkError, AddLinkAccountOtp>> addLinkAccountOtp({
    required String aliasId,
    required String linkType,
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> confirmChangeDefaultAccount(
      {required String acc, required String aliasId, required String otpCode});

  Future<Either<NetworkError, ChangeDefaultAccountOtp>> changeDefaultAccountOtp(
      {required String acc, required String aliasId});

  Future<Either<NetworkError, bool>> unLinkAccountFromCliq({
    required String aliasId,
    required String accountId,
    required String otpCode,
    required bool getToken,
  });

  Future<Either<NetworkError, UnlinkCliqIdOtp>> unLinkAccountFromCliqOtp({
    required String aliasId,
    required String accountId,
    required bool getToken,
  });

  Future<Either<NetworkError, PaymentActivityResponse>> requestMoneyActivity({
    required int FilterDays,
    required String TransactionType,
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
    required String otpCode,
    required bool getToken,
  });

  Future<Either<NetworkError, SuspendCliqIdOtp>> suspendCliqIdOtp({
    required String aliasId,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> reActivateCliqId({
    required String aliasId,
    required String otpCode,
    required bool getToken,
  });

  Future<Either<NetworkError, ReActivateCliqIdOtp>> reActivateCliqIdOtp({
    required String aliasId,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> deleteCliqId({
    required String aliasId,
    required String otpCode,
    required bool getToken,
  });

  Future<Either<NetworkError, DeleteCliqIdOtp>> deleteCliqIdOtp({
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

  Future<Either<NetworkError, EditCliqOtp>> editCliqIdOtp({
    required String aliasId,
    required bool isAlias,
    required String aliasValue,
    required bool getToken,
  });

  Future<Either<NetworkError, bool>> requestToPayResult({
    required String CustID,
    required String OrgnlMsgId,
    required String RTPStatus,
    required String RejectReason,
    required String RejectADdInfo,
    required bool GetToken,
  });

  Future<Either<NetworkError, List<GetAccountByCustomerId>>> getAccountByCustomerID();

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
      required String OrgnlMsgId,
      required String CtgyPurp,
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

  Future<Either<NetworkError, List<RejectionReasonInward>>> getRejectionReasons();
}
