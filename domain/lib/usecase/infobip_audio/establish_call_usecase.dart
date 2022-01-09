import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/help_canter.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EstablishCallUseCase
    extends BaseUseCase<BaseError, EstablishCallUseCaseParams, bool> {
  final HelpCenterRepository _helpCenterRepository;

  EstablishCallUseCase(this._helpCenterRepository);

  @override
  Future<Either<BaseError, bool>> execute({required EstablishCallUseCaseParams params}) {
      return _helpCenterRepository.establishCall();
  }
}

class EstablishCallUseCaseParams extends Params {
  EstablishCallUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
