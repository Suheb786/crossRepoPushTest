import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class IdCardRepository {
  /// get ahwal details
  Future<Either<NetworkError, String>> getAhwalDetails({required String idNo});
}
