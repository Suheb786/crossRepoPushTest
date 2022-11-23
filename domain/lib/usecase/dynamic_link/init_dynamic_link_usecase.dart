import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/dynamic_link/dynamic_link_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class InitDynamicLinkUseCase extends BaseUseCase<BaseError, InitDynamicLinkUseCaseParams, Uri> {
  final DynamicLinkRepository _dynamicLinkRepository;

  InitDynamicLinkUseCase(this._dynamicLinkRepository);

  @override
  Future<Either<BaseError, Uri>> execute({required InitDynamicLinkUseCaseParams params}) {
    return _dynamicLinkRepository.initDynamicLinks();
  }
}

class InitDynamicLinkUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
