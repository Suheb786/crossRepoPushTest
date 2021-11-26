import 'package:data/entity/remote/bank_smart/get_account_response_entity.dart';
import 'package:data/entity/remote/bank_smart/purpose_of_account_opening_response_entity.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:retrofit/retrofit.dart';

abstract class BankSmartRemoteDS {
  Future<HttpResponse<PurposeOfAccountOpeningResponseEntity>> addAccountPurpose(
      {required bool getToken,
      String? purpose,
      bool? isCashDeposit,
      bool? isTransfer,
      bool? isBillPayment,
      bool? isOther,
      double? monthlyTransaction,
      double? annualTransaction});

  Future<HttpResponse<GetAccountResponseEntity>> getAccount(
      {bool getToken});

  Future<String> createAccount(
      {bool getToken,
      CustomerInformation? customerInformation,
      CustomerAccountDetails? accountDetails});

  Future<String> getAccountDetails({bool getToken});
}

abstract class BankSmartLocalDS {}
