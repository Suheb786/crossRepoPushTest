import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/help_canter.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class InfobipAudioPluginUseCase extends BaseUseCase<BaseError, InfobipAudioPluginUseCaseParams, bool> {
  final HelpCenterRepository _helpCenterRepository;

  InfobipAudioPluginUseCase(this._helpCenterRepository);

  @override
  Future<Either<BaseError, bool>> execute({required InfobipAudioPluginUseCaseParams params}) async {
    return _helpCenterRepository.initInfobip(params.callback);
  }
}

class InfobipAudioPluginUseCaseParams extends Params {
  final Function(InfobipCallStatusEnum) callback;

  InfobipAudioPluginUseCaseParams({required this.callback});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
