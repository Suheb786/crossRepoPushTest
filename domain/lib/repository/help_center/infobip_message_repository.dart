import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class InfobipMessageRepository {
  Future<Either<NetworkError, bool>> initInfobipMessage();
}
