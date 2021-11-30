import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:domain/model/bank_smart/get_account_details_response.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/model/bank_smart/purpose_of_account_opening_response.dart';

abstract class BankSmartRepository {
  /// add account of opening purpose
  Future<Either<NetworkError, PurposeOfAccountOpeningResponse>>
      addAccountPurpose(
          {required bool getToken,
          String? purpose,
          bool? isCashDeposit,
          bool? isTransfer,
          bool? isBillPayment,
          bool? isOther,
          double? monthlyTransaction,
          double? annualTransaction});

  /// get account
  Future<Either<NetworkError, GetAccountResponse>> getAccount(
      {required bool getToken});

  /// create account
  Future<Either<NetworkError, CreateAccountResponse>> createAccount(
      {required bool getToken,
      CustomerInformation? customerInformation,
      CustomerAccountDetails? accountDetails});

  /// get account details
  Future<Either<NetworkError, GetAccountDetailsResponse>> getAccountDetails(
      {required bool getToken});
}
