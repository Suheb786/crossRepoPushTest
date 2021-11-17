import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

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
}
