import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/bank_smart/add_account_purpose_request.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/bank_smart/bank_smart_datasource.dart';

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
}
