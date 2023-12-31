import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/infobip_message_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ShowChatUseCase extends BaseUseCase<BaseError, ShowChatUseCaseParams, bool> {
  final InfobipMessageRepository _infobipMessageRepository;

  ShowChatUseCase(this._infobipMessageRepository);

  @override
  Future<Either<BaseError, bool>> execute({required ShowChatUseCaseParams params}) async {
    return _infobipMessageRepository.showChat();
  }
}

class ShowChatUseCaseParams extends Params {
  ShowChatUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
