import 'package:data/entity/remote/card/card_issuance_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class CardRemoteDs {
  Future<HttpResponse<CardIssuanceResponseEntity>> getCardIssuanceDetails();

  Future<HttpResponse<ResponseEntity>> setCardPin(String pin);

  Future<HttpResponse<ResponseEntity>> confirmCardDelivery();
}
