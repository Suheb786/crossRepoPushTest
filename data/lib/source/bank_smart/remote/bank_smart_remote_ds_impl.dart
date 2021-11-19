import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/bank_smart/account_details_entity.dart';
import 'package:data/entity/remote/bank_smart/add_account_purpose_request.dart';
import 'package:data/entity/remote/bank_smart/create_account_request_entity.dart';
import 'package:data/entity/remote/bank_smart/customer_details_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_details_request_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_request_entity.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/bank_smart/bank_smart_datasource.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';

class BankSmartRemoteDSImpl extends BankSmartRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  BankSmartRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<String> addAccountPurpose(
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
        baseData: baseData,
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
  Future<String> getAccount({bool? getToken, String? productCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getAccount(GetAccountRequestEntity(
        baseData: baseData, productCode: productCode, getToken: getToken));
  }

  @override
  Future<String> createAccount(
      {bool? getToken,
      String? cif,
      CustomerInformation? customerInformation,
      CustomerAccountDetails? accountDetails}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.createAccount(CreateAccountRequestEntity(
        baseData: baseData,
        cif: cif,
        getToken: getToken,
        customerDetailsEntity:
            CustomerDetailsEntity().restore(customerInformation!),
        account: AccountDetailsEntity().restore(accountDetails!)));
  }

  @override
  Future<String> getAccountDetails({bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getAccountDetails(
        GetAccountDetailsRequestEntity(baseData: baseData, getToken: getToken));
  }
}
