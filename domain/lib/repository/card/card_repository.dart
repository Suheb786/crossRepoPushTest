import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class CardRepository {
  Future<Either<NetworkError, String>> getCardIssuanceDetails();

  Future<Either<NetworkError, bool>> setCardPin(String currentPin);
}
