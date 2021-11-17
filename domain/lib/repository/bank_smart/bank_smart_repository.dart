import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class BankSmartRepository {
  /// add account of opening purpose
  Future<Either<NetworkError, String>> checkBankSmartStatus({required bool getToken});
}
