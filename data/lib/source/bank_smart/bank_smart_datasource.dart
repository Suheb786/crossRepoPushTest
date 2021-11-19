import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';

abstract class BankSmartRemoteDS {
  Future<String> addAccountPurpose(
      {required bool getToken,
      String? purpose,
      bool? isCashDeposit,
      bool? isTransfer,
      bool? isBillPayment,
      bool? isOther,
      double? monthlyTransaction,
      double? annualTransaction});

  Future<String> getAccount({bool getToken, String? productCode});

  Future<String> createAccount(
      {bool getToken,
      String? cif,
      CustomerInformation? customerInformation,
      CustomerAccountDetails? accountDetails});

  Future<String> getAccountDetails({bool getToken});
}

abstract class BankSmartLocalDS {}
