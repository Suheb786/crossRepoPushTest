import 'package:dartz/dartz.dart';
import 'package:domain/error/database_error.dart';

abstract class AppFlyerRepository {
  /// init sdk
  Future<Either<DatabaseError, bool>> initAppFlyerSdk();

  /// log events
  Future<Either<DatabaseError, bool>> logAppFlyerEvent({required String eventName, required Map eventValue});
}
