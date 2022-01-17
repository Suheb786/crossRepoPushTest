import 'package:dartz/dartz.dart';
import 'package:domain/error/local_error.dart';

abstract class UtilityRepository {
  /// Check Device Compatibility
  Future<Either<LocalError, bool>> checkDeviceCompatibility();
}
