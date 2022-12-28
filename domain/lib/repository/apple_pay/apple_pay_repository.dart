import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/apple_pay/enroll_card_response.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';

abstract class ApplePayRepository {
  /// get all card list
  Future<Either<NetworkError, GetDashboardDataResponse>> getAllCardListUseCase();

  /// add user wallet detail
  Future<Either<NetworkError, bool>> addUserWalletDetail(
      {required String walletId, required String entrustWalletId});

  /// get user wallet detail
  Future<Either<NetworkError, bool>> getUserWalletDetail();

  /// enroll cards
  Future<Either<NetworkError, EnrollCardResponse>> enrollCards(
      {required String walletId, required String cardId, required String cardType});

  /// initialize SDK
  Future<Either<NetworkError, bool>> initializeAntelop();

  /// get antelop cards
  Future<Either<NetworkError, bool>> getAntelopCards();
}
