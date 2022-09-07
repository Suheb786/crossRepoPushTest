import 'package:dartz/dartz.dart';
import 'package:data/db/safe_db_call.dart';
import 'package:data/source/app_flyer_source/app_flyer_datasource.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/repository/app_flyer_repository/app_flyer_repository.dart';

class AppFlyerRepositoryImpl extends AppFlyerRepository {
  final AppFlyerDataSource _appFlyerDataSource;

  AppFlyerRepositoryImpl(this._appFlyerDataSource);

  @override
  Future<Either<DatabaseError, bool>> initAppFlyerSdk() async {
    final result = await safeDbCall(
      _appFlyerDataSource.initAppFlyerSdk(),
    );
    return result.fold(
      (l) => Left(l),
      (r) => Right(true),
    );
  }

  @override
  Future<Either<DatabaseError, bool>> logAppFlyerEvent(
      {required String eventName, required Map eventValue}) async {
    final result = await safeDbCall(
      _appFlyerDataSource.logAppFlyerEvent(eventName: eventName, eventValue: eventValue),
    );
    return result.fold(
      (l) => Left(l),
      (r) => Right(true),
    );
  }
}
