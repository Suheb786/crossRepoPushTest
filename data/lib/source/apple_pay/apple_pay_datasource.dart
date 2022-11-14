import 'package:data/entity/remote/apple_pay/enroll_card_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class ApplePayRemoteDataSource {
  Future<HttpResponse<ResponseEntity>> getAllCardListUseCase();

  Future<HttpResponse<ResponseEntity>> addUserWalletDetail(
      {required String walletId, required String entrustWalletId});

  Future<HttpResponse<ResponseEntity>> getUserWalletDetail();

  Future<HttpResponse<EnrollCardResponseEntity>> enrollCards(
      {required String walletId, required String cardId, required String cardType});

  Future<bool> initializeAntelopSDK();
}
