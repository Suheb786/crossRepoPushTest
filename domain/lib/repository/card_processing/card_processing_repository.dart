import 'package:dartz/dartz.dart';
import 'package:domain/error/local_error.dart';

mixin CardProcessingRepository {
  /// Decrypt Card Number
  Future<Either<LocalError, String>> decryptCard({required String cardNo});

  /// Decrypt Generate Block Pin
  Future<Either<LocalError, String>> generateBlockPin({required String cardNo, required String pinCode});
}
