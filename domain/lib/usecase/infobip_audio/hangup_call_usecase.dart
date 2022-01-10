import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/help_canter.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class HangupCallUseCase
    extends BaseUseCase<BaseError, HangupCallUseCaseParams, bool> {
  final HelpCenterRepository _helpCenterRepository;

  HangupCallUseCase(this._helpCenterRepository);

  @override
  Future<Either<BaseError, bool>> execute(
      {required HangupCallUseCaseParams params}) {
    return _helpCenterRepository.callHangUp();
  }
}

class HangupCallUseCaseParams extends Params {
  HangupCallUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
