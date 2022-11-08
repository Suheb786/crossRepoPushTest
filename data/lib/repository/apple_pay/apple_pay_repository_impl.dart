import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/apple_pay/apple_pay_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/apple_pay/apple_pay_repository.dart';

class ApplePayRepositoryImpl extends ApplePayRepository {
  final ApplePayRemoteDataSource applePayRemoteDataSource;

  ApplePayRepositoryImpl(this.applePayRemoteDataSource);

  @override
  Future<Either<NetworkError, bool>> addUserWalletDetail(
      {required String walletId, required String entrustWalletId}) async {
    final result = await safeApiCall(
        applePayRemoteDataSource.addUserWalletDetail(entrustWalletId: entrustWalletId, walletId: walletId));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> enrollCards(
      {required String walletId, required String cardId, required String cardType}) async {
    final result = await safeApiCall(
        applePayRemoteDataSource.enrollCards(cardId: cardId, walletId: walletId, cardType: cardType));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> getAllCardListUseCase() async {
    final result = await safeApiCall(applePayRemoteDataSource.getAllCardListUseCase());
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> getUserWalletDetail() async {
    final result = await safeApiCall(applePayRemoteDataSource.getUserWalletDetail());
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> initializeAntelop() async {
    final result = await safeApiCall(
      applePayRemoteDataSource.initializeAntelopSDK(),
    );

    return result!.fold(
      (l) => Left(l),
      (r) => Right(true),
    );
  }
}
