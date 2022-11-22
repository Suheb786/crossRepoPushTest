import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/infobip_message_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DepersonalizeUserUseCase extends BaseUseCase<BaseError, DepersonalizeUserUseCaseParams, bool> {
  final InfobipMessageRepository _infobipMessageRepository;

  DepersonalizeUserUseCase(this._infobipMessageRepository);

  @override
  Future<Either<BaseError, bool>> execute({required DepersonalizeUserUseCaseParams params}) async {
    return _infobipMessageRepository.depersonalizeUser();
  }
}

class DepersonalizeUserUseCaseParams extends Params {
  DepersonalizeUserUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
