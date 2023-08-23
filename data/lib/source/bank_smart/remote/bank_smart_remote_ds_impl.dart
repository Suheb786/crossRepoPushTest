import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/bank_smart/account_details_entity.dart';
import 'package:data/entity/remote/bank_smart/add_account_purpose_request.dart';
import 'package:data/entity/remote/bank_smart/create_account_request_entity.dart';
import 'package:data/entity/remote/bank_smart/create_account_response_entity.dart';
import 'package:data/entity/remote/bank_smart/customer_details_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_details_request_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_details_response_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_request_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_response_entity.dart';
import 'package:data/entity/remote/bank_smart/purpose_of_account_opening_response_entity.dart';
import 'package:data/entity/remote/bank_smart/remove_debit_lock_request_entity.dart';
import 'package:data/entity/remote/bank_smart/remove_debit_lock_response_entity.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/bank_smart/bank_smart_datasource.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:retrofit/dio.dart';

class BankSmartRemoteDSImpl extends BankSmartRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  BankSmartRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<PurposeOfAccountOpeningResponseEntity>> addAccountPurpose(
      {required bool getToken,
      String? purpose,
      bool? isCashDeposit,
      bool? isTransfer,
      bool? isBillPayment,
      bool? isOther,
      double? monthlyTransaction,
      double? annualTransaction}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.addAccountPurpose(AddAccountPurposeRequest(
        baseData: baseData.toJson(),
        getToken: getToken,
        purpose: purpose,
        isCashDeposit: isCashDeposit,
        isTransfer: isTransfer,
        isBillPayment: isBillPayment,
        isOther: isOther,
        monthlyTransaction: monthlyTransaction,
        annualTransaction: annualTransaction));
  }

  @override
  Future<HttpResponse<GetAccountResponseEntity>> getAccount({bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getAccount(GetAccountRequestEntity(baseData: baseData.toJson(), getToken: getToken));
  }

  @override
  Future<HttpResponse<CreateAccountResponseEntity>> createAccount(
      {bool? getToken,
      String? cif,
      bool? isSubAccount,
      CustomerInformation? customerInformation,
      CustomerAccountDetails? accountDetails}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.createAccount(CreateAccountRequestEntity(
        cif: cif,
        iIsSubAccount: isSubAccount,
        baseData: baseData.toJson(),
        getToken: true,
        customerDetailsEntity: CustomerDetailsEntity().restore(customerInformation!).toJson(),
        account: AccountDetailsEntity().restore(accountDetails!).toJson()));
  }

  @override
  Future<HttpResponse<GetAccountDetailsResponseEntity>> getAccountDetails({bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getAccountDetails(GetAccountDetailsRequestEntity(baseData: baseData, getToken: true));
  }

  @override
  Future<HttpResponse<RemoveDebitLockResponseEntity>> removeDebitLock() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .removeDebitLock(RemoveDebitLockRequestEntity(baseData: baseData.toJson(), getToken: true));
  }
}
