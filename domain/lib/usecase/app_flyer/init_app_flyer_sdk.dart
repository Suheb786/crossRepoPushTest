import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/repository/app_flyer_repository/app_flyer_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class InitAppFlyerSDKUseCase extends BaseUseCase<DatabaseError, InitAppFlyerSDKUseCaseParams, bool> {
  final AppFlyerRepository _appFlyerRepository;

  InitAppFlyerSDKUseCase(this._appFlyerRepository);

  @override
  Future<Either<DatabaseError, bool>> execute({required InitAppFlyerSDKUseCaseParams params}) {
    return _appFlyerRepository.initAppFlyerSdk();
  }
}

class InitAppFlyerSDKUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
