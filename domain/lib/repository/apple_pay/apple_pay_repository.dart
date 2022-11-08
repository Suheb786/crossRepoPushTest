import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class ApplePayRepository {
  /// get all card list
  Future<Either<NetworkError, bool>> getAllCardListUseCase();

  /// add user wallet detail
  Future<Either<NetworkError, bool>> addUserWalletDetail(
      {required String walletId, required String entrustWalletId});

  /// get user wallet detail
  Future<Either<NetworkError, bool>> getUserWalletDetail();

  /// enroll cards
  Future<Either<NetworkError, bool>> enrollCards(
      {required String walletId, required String cardId, required String cardType});

  /// initialize SDK
  Future<Either<NetworkError, bool>> initializeAntelop();
}
