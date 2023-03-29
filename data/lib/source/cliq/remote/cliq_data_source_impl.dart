import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/cliq/add_link_account/add_link_account_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/add_link_account/add_link_account_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/add_link_account/add_link_account_request_entity.dart';
import 'package:data/entity/remote/cliq/approve_RTP_request_request/approve_RTP_request_request_request_entity.dart';
import 'package:data/entity/remote/cliq/change_default_account_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/confirm_change_default_account_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/confirm_change_default_account_request_entity.dart';
import 'package:data/entity/remote/cliq/confirm_create_cliq_id/confirm_create_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/confirm_create_cliq_id/confirm_create_cliq_id_response_entity.dart';
import 'package:data/entity/remote/cliq/create_cliq_id_otp/create_cliq_id_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/create_cliq_id_otp/create_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/delete_cliq_id_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/delete_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/delete_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id/edit_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id/edit_cliq_id_response_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id_otp/edit_cliq_id_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id_otp/edit_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/get_account_by_customer_id/get_account_by_customer_id_response_entity.dart';
import 'package:data/entity/remote/cliq/get_alias/get_alias_request_entity.dart';
import 'package:data/entity/remote/cliq/get_alias/get_alias_response_entity.dart';
import 'package:data/entity/remote/cliq/get_customer_by_account/get_customer_by_account_request_entity.dart';
import 'package:data/entity/remote/cliq/re_activate_cliq_id_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/re_activate_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/re_activate_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/request_money_activity/request_money_activity_request_entity.dart';
import 'package:data/entity/remote/cliq/request_to_pay_result/request_to_pay_result_request_entity.dart';
import 'package:data/entity/remote/cliq/submit_outward_payment/submit_outward_payment_request_entity.dart';
import 'package:data/entity/remote/cliq/suspend_cliq_id_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/suspend_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/suspend_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/unlink_account_from_cliq/unlink_account_from_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/unlink_account_from_cliq/unlink_account_from_cliq_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/unlink_account_from_cliq/unlink_account_from_cliq_request_entity.dart';
import 'package:data/entity/remote/cliq/update_rtp_request_entity.dart';
import 'package:data/entity/remote/payment/payment_activity_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/cliq/clip_data_source.dart';
import 'package:retrofit/dio.dart';

class CliqRemoteDataSourceImpl extends CliqDataSource {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  CliqRemoteDataSourceImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<GetAliasResponseEntity>> getAlias({required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getAlias(CliqGetAliasRequestEntity(baseData: baseData.toJson(), getToken: getToken));
  }

  @override
  Future<HttpResponse<PaymentActivityResponseEntity>> requestMoneyActivity({
    required bool getToken,
    required int FilterDays,
    required String TransactionType,
  }) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.requestMoneyActivity(RequestMoneyActivityRequestEntity(
        FilterDays: FilterDays,
        TransactionType: TransactionType,
        getToken: getToken,
        baseClass: baseData.toJson()));
  }

/*  @override
  Future<HttpResponse<ResponseEntity>> getCliqAccountByAlias(
      {required String alias,
      required String mobileNo,
      required String iban,
      required String accountNo,
      required String swiftCode,
      required String bankCountry,
      required String transferType,
      required String cliqType,
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getCliqAccountByAlias(GetCliqAccountByAliasEntity(
        alias: alias,
        mobileNo: mobileNo,
        iban: iban,
        accountNo: accountNo,
        swiftCode: swiftCode,
        bankCountry: bankCountry,
        transferType: transferType,
        cliqType: cliqType,
        getToken: getToken,
        baseClass: baseData.toJson()));
  }*/

  @override
  Future<HttpResponse<ConfirmCreateCliqIdResponseEntity>> confirmCreateCLidID(
      {required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required String otpCode,
      required bool getToken,
      required bool isSetDefault}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.confirmCreateCLidID(ConfirmCreateCliqIdRequestEntity(
        accountNumber: accountNumber,
        aliasValue: aliasValue,
        otpCode: otpCode,
        isAlias: isAlias,
        getToken: getToken,
        isSetDefault: isSetDefault,
        baseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<CreateCliqIdOtpResponseEntity>> createCliqIdOtp(
      {required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.createCliqIdOtp(CreateCliqIdOtpRequestEntity(
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        getToken: getToken,
        baseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> addLinkAccount(
      {required String aliasId,
      required String linkType,
      required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required String otpCode,
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.addLinkAccount(AddLinkAccountRequestEntity(
        aliasId: aliasId,
        linkType: linkType,
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        otpCode: otpCode,
        getToken: getToken,
        baseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<AddLinkAccountOtpResponseEntity>> addLinkAccountOtp(
      {required String aliasId,
      required String linkType,
      required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.addLinkAccountOtp(AddLinkAccountOtpRequestEntity(
        aliasId: aliasId,
        linkType: linkType,
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        getToken: getToken,
        baseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> confirmChangeDefaultAccount(
      {required String acc, required String aliasId, required String otpCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.confirmChangeDefaultAccount(
      ConfirmChangeDefaultAccountRequestEntity(
          getToken: true, acc: acc, aliasId: aliasId, otpCode: otpCode, baseClass: baseData.toJson()),
    );
  }

  @override
  Future<HttpResponse<EditCliqResponseEntity>> editCliqID(
      {required bool isAlias,
      required String aliasId,
      required String aliasValue,
      required String OtpCode,
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.editCliqID(EditCliqIdRequestEntity(
        isAlias: isAlias,
        aliasValue: aliasValue,
        aliasId: aliasId,
        getToken: getToken,
        OtpCode: OtpCode,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> deleteCliqId(
      {required String aliasId, required String otpCode, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.deleteCliqId(DeleteCliqIdRequestEntity(
        aliasId: aliasId, otpCode: otpCode, getToken: getToken, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<DeleteCliqIdOtpResponseEntity>> deleteCliqIdOtp(
      {required String aliasId, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.deleteCliqIdOtp(
        DeleteCliqIdOtpRequestEntity(aliasId: aliasId, getToken: getToken, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> reActivateCliqId(
      {required String aliasId, required String otpCode, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.reActivateCliqId(ReActivateCliqIdRequestEntity(
        getToken: getToken, aliasId: aliasId, otpCode: otpCode, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ReActivateCliqIdOtpResponseEntity>> reActivateCliqIdOtp(
      {required String aliasId, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.reActivateCliqIdOtp(
        ReActivateCliqIdOtpRequestEntity(aliasId: aliasId, getToken: getToken, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> suspendCliqId(
      {required String aliasId, required String otpCode, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.suspendCliqId(SuspendCliqIdRequestEntity(
        aliasId: aliasId, otpCode: otpCode, getToken: getToken, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<SuspendCliqIdOtpResponseEntity>> suspendCliqIdOtp(
      {required String aliasId, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.suspendCliqIdOtp(
        SuspendCliqIdOtpRequestEntity(aliasId: aliasId, getToken: getToken, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unLinkAccountFromCliq(
      {required String aliasId,
      required String accountId,
      required String otpCode,
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.unLinkAccountFromCliq(UnLinkAccountFromCliqRequestEntity(
        aliasId: aliasId,
        accountId: accountId,
        otpCode: otpCode,
        getToken: getToken,
        baseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<UnlinkAccountFromCliqIdOtpResponseEntity>> unLinkAccountFromCliqOtp(
      {required String aliasId, required String accountId, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.unLinkAccountFromCliqOtp(UnLinkAccountFromCliqOtpRequestEntity(
        aliasId: aliasId, accountId: accountId, getToken: getToken, baseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> updateRTPCliqRequest(
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
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.updateRTPCliqRequest(UpdateRtpRequestEntity(
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
        getToken: getToken,
        baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<EditCliqOtpResponseEntity>> editCliqIdOtp(
      {required String aliasId,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.editCliqIdOtp(EditCliqOtpRequestEntity(
        aliasId: aliasId,
        isAlias: isAlias,
        aliasValue: aliasValue,
        GetToken: getToken,
        baseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> requestToPayResult(
      {required String CustID,
      required String OrgnlMsgId,
      required String RTPStatus,
      required String RejectReason,
      required bool GetToken,
      required String RejectADdInfo}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.requestToPayResult(RequestToPayResultRequestEntity(
      CustID: CustID,
      OrgnlMsgId: OrgnlMsgId,
      RTPStatus: RTPStatus,
      RejectReason: RejectReason,
      RejectADdInfo: RejectADdInfo,
      GetToken: GetToken,
      BaseClass: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<GetAccountByCustomerIdResponseEntity>> getAccountByCustomerID() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getAccountByCustomerID(BaseRequest(getToken: true, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ChangeDefaultAccountOtpResponseEntity>> changeDefaultAccountOtp({
    required String acc,
    required String aliasId,
  }) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changeDefaultAccountOtp(ConfirmChangeDefaultAccountOtpRequestEntity(
        getToken: true, baseClass: baseData.toJson(), acc: acc, aliasId: aliasId));
  }

  @override
  Future<HttpResponse<ResponseEntity>> approveRTPRequest(
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
      required bool GetToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.approveRTPRequest(ApproveRTPRequestReqestEntity(
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
      GetToken: GetToken,
      BaseClass: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<ResponseEntity>> submitOutwardPayment(
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
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.submitOutwardPayment(SubmitOutwardPaymentRequestEntity(
        custID,
        dbtrAcct,
        dbtrName,
        dbtrPstlAdr,
        dbtrRecordID,
        dbtrAlias,
        currency,
        amount,
        purposE_CODE,
        cdtrBic,
        cdtrName,
        cdtrAcct,
        cdtrPstlAdr,
        cdtrRecordID,
        cdtrAlias,
        rgltryRptg,
        CustIDTO,
        DbtrIsIndvl,
        CdtrIsIndvl,
        RmtInf,
        QRFlag,
        GetToken,
        baseData.toJson()));
  }
}
