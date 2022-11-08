import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class ApplePayRemoteDataSource {
  Future<HttpResponse<ResponseEntity>> getAllCardListUseCase();

  Future<HttpResponse<ResponseEntity>> addUserWalletDetail(
      {required String walletId, required String entrustWalletId});

  Future<HttpResponse<ResponseEntity>> getUserWalletDetail();

  Future<HttpResponse<ResponseEntity>> enrollCards(
      {required String walletId, required String cardId, required String cardType});

  Future<bool> initializeAntelopSDK();
}
