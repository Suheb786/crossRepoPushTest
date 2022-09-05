import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/repository/app_flyer_repository/app_flyer_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class LogAppFlyerSDKEventsUseCase
    extends BaseUseCase<DatabaseError, LogAppFlyerSDKEventsUseCaseParams, bool> {
  final AppFlyerRepository _appFlyerRepository;

  LogAppFlyerSDKEventsUseCase(this._appFlyerRepository);

  @override
  Future<Either<DatabaseError, bool>> execute({required LogAppFlyerSDKEventsUseCaseParams params}) {
    return _appFlyerRepository.logAppFlyerEvent(eventName: params.eventName, eventValue: params.eventValue);
  }
}

class LogAppFlyerSDKEventsUseCaseParams extends Params {
  final String eventName;
  final Map eventValue;

  LogAppFlyerSDKEventsUseCaseParams({required this.eventName, required this.eventValue});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
