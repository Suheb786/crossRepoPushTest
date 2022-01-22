import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/infobip_message_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SaveUserUseCase
    extends BaseUseCase<BaseError, SaveUserUseCaseParams, bool> {
  final InfobipMessageRepository _infobipMessageRepository;

  SaveUserUseCase(this._infobipMessageRepository);

  @override
  Future<Either<BaseError, bool>> execute(
      {required SaveUserUseCaseParams params}) async {
    return _infobipMessageRepository.saveUser();
  }
}

class SaveUserUseCaseParams extends Params {
  SaveUserUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
