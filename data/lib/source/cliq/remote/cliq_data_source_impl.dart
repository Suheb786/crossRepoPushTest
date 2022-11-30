import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/cliq/add_link_account/add_link_account_request_entity.dart';
import 'package:data/entity/remote/cliq/change_default_account/change_default_account_request_entity.dart';
import 'package:data/entity/remote/cliq/delete_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/re_activate_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/request_money/request_money_request_entity.dart';
import 'package:data/entity/remote/cliq/request_money_activity/request_money_activity_request_entity.dart';
import 'package:data/entity/remote/cliq/suspend_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/unlink_account_from_cliq/unlink_account_from_cliq_request_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/cliq/clip_data_source.dart';
import 'package:retrofit/dio.dart';
import 'package:data/entity/remote/cliq/get_alias/get_alias_request_entity.dart';
import 'package:data/entity/remote/cliq/cliq_get_account_by_alias/cliq_get_account_by_alias.dart';
import 'package:data/entity/remote/cliq/create_cliq_id/create_cliq_id_request_entity.dart';

class CliqRemoteDataSourceImpl extends CliqDataSource {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  CliqRemoteDataSourceImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<ResponseEntity>> getAlias(
      {required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getAlias(CliqGetAliasResponseEntity(
        baseData: baseData.toJson(), getToken: getToken));
  }

  @override
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
  }

  @override
  Future<HttpResponse<ResponseEntity>> createCliqId(
      {required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.createCliqId(CreateCliqIdRequestEntity(
        accountNumber: accountNumber,
        aliasValue: aliasValue,
        isAlias: isAlias,
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
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.addLinkAccount(AddLinkAccountRequestEntity(
        aliasId: aliasId,
        linkType: linkType,
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        getToken: getToken,
        baseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> changeDefaultAccount(
      {required String linkType,
      required String otpCode,
      required String identifier,
      required String aliasId,
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.changeDefaultAccount(ChangeDefaultAccountRequestEntity(
        linkType: linkType,
        otpCode: otpCode,
        identifier: identifier,
        aliasId: aliasId,
        getToken: getToken,
        baseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> editCliqID(
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
      {required String aliasId, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.deleteCliqId(DeleteCliqIdRequestEntity(
        aliasId: aliasId, getToken: getToken, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> reActivateCliqId(
      {required String aliasId, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.reActivateCliqId(ReActivateCliqIdRequestEntity(
        getToken: getToken, aliasId: aliasId, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> suspendCliqId(
      {required String aliasId, required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.suspendCliqId(SuspendCliqIdRequestEntity(
        aliasId: aliasId, getToken: getToken, baseData: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> unLinkAccountFromCliq(
      {required String aliasId,
      required String accountId,
      required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.unLinkAccountFromCliq(UnLinkAccountFromCliqRequestEntity(
        aliasId: aliasId,
        accountId: accountId,
        getToken: getToken,
        baseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> requestMoney(
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
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.requestMoney(RequestMoneyRequestEntity(
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
        getToken: getToken,
        baseClass: baseData.toJson()));
  }

  @override
  Future<HttpResponse<ResponseEntity>> requestMoneyActivity(
      {required bool getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.requestMoneyActivity(RequestMoneyActivityRequestEntity(
        getToken: getToken, baseClass: baseData.toJson()));
  }
}
