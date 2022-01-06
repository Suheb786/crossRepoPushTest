import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/help_canter.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SpeakerOnOffUseCase
    extends BaseUseCase<BaseError, SpeakerOnOffUseCaseParams, bool> {
  final HelpCenterRepository _helpCenterRepository;

  SpeakerOnOffUseCase(this._helpCenterRepository);

  @override
  Future<Either<BaseError, bool>> execute(
      {required SpeakerOnOffUseCaseParams params}) {
    return _helpCenterRepository.toggleSpeaker();
  }
}

class SpeakerOnOffUseCaseParams extends Params {
  SpeakerOnOffUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
