import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/help_canter.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ObtainTokenUseCase
    extends BaseUseCase<BaseError, ObtainTokenUseCaseParams, String> {
  final HelpCenterRepository _helpCenterRepository;

  ObtainTokenUseCase(this._helpCenterRepository);

  @override
  Future<Either<BaseError, String>> execute(
      {required ObtainTokenUseCaseParams params}) {
    return _helpCenterRepository.obtainToken(params.parameter);
  }
}

class ObtainTokenUseCaseParams extends Params {
  final Map<String, String> parameter;

  ObtainTokenUseCaseParams({required this.parameter});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
