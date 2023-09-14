import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/dynamic_link/dynamic_link_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ReferDynamicLinkUseCase extends BaseUseCase<BaseError, ReferDynamicLinkUseCaseParams, String> {
  final DynamicLinkRepository _dynamicLinkRepository;

  ReferDynamicLinkUseCase(this._dynamicLinkRepository);

  @override
  Future<Either<BaseError, String>> execute({required ReferDynamicLinkUseCaseParams params}) {
    return _dynamicLinkRepository.referDynamicLink(
      userPromoCode: params.userPromoCode,
    );
  }
}

class ReferDynamicLinkUseCaseParams extends Params {
  final String userPromoCode;

  ReferDynamicLinkUseCaseParams({
    required this.userPromoCode,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
