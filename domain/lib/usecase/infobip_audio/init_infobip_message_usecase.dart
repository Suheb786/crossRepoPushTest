import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/infobip_message_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class InfobipMessagePluginUseCase
    extends BaseUseCase<BaseError, InfobipMessagePluginUseCaseParams, bool> {
  final InfobipMessageRepository _infobipMessageRepository;

  InfobipMessagePluginUseCase(this._infobipMessageRepository);

  @override
  Future<Either<BaseError, bool>> execute(
      {required InfobipMessagePluginUseCaseParams params}) async {
    return await _infobipMessageRepository.initInfobipMessage(params.callback);
  }
}

class InfobipMessagePluginUseCaseParams extends Params {
  final Function callback;

  InfobipMessagePluginUseCaseParams({required this.callback});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
