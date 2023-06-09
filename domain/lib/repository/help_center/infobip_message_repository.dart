import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class InfobipMessageRepository {
  Future<Either<NetworkError, bool>> initInfobipMessage();

  Future<Either<NetworkError, bool>> showChat();

  Future<Either<NetworkError, bool>> saveUser();

  Future<Either<NetworkError, bool>> depersonalizeUser();
}
