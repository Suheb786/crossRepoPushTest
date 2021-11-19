import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';

abstract class BankSmartRepository {
  /// add account of opening purpose
  Future<Either<NetworkError, String>> addAccountPurpose(
      {required bool getToken,
      String? purpose,
      bool? isCashDeposit,
      bool? isTransfer,
      bool? isBillPayment,
      bool? isOther,
      double? monthlyTransaction,
      double? annualTransaction});

  /// get account
  Future<Either<NetworkError, String>> getAccount(
      {required bool getToken, String? productCode});

  /// create account
  Future<Either<NetworkError, String>> createAccount(
      {required bool getToken,
      String? cif,
      CustomerInformation? customerInformation,
      CustomerAccountDetails? accountDetails});

  /// get account details
  Future<Either<NetworkError, String>> getAccountDetails(
      {required bool getToken});
}
