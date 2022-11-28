import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/help_canter.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CallDurationUseCase extends BaseUseCase<BaseError, CallDurationUseCaseParams, int> {
  final HelpCenterRepository _helpCenterRepository;

  CallDurationUseCase(this._helpCenterRepository);

  @override
  Future<Either<BaseError, int>> execute({required CallDurationUseCaseParams params}) {
    return _helpCenterRepository.getCallDuration();
  }
}

class CallDurationUseCaseParams extends Params {
  CallDurationUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
