import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/help_canter.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class MuteUnMuteUseCase extends BaseUseCase<BaseError, MuteUnMuteUseCaseParams, bool> {
  final HelpCenterRepository _helpCenterRepository;

  MuteUnMuteUseCase(this._helpCenterRepository);

  @override
  Future<Either<BaseError, bool>> execute({required MuteUnMuteUseCaseParams params}) {
    return _helpCenterRepository.muteUnMute();
  }
}

class MuteUnMuteUseCaseParams extends Params {
  MuteUnMuteUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
